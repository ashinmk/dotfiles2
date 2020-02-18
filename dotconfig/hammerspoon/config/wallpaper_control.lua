---------------------- Begin Config

local wallpaperDir = "/tmp/wallpapers";
local configFilePath = wallpaperDir .. '/config.json';
local wallpaperResourceDir = wallpaperDir .. "/img";
local unsplashApiKey = readFileContents(os.getenv("HOME") .. "/.grw-priv/unsplashApiKey");
local unsplashRelevantCollections = {1228};

---------------------- End Config


local wallpaperConfig;

local saveConfig = function()
    writeToFile(configFilePath, hs.json.encode(wallpaperConfig));
end

local loadConfig = function()
    if fileExists(configFilePath) then
        wallpaperConfig = hs.json.decode(readFileContents(configFilePath));
    else
        wallpaperConfig = {};
        wallpaperConfig.currentWallpaperIndex = 0;
        wallpaperConfig.wallpapers = {};
        saveConfig();
    end
end


---------------------- Init Resources

hs.fs.mkdir(wallpaperDir);
hs.fs.mkdir(wallpaperResourceDir);

loadConfig();

---------------------- End Init Resources


---------------------- Wallpaper Resource Access

local changeWallpaperToFile = function(fileUrl)
    local screens = hs.screen.allScreens();
    for i = 1, #screens do
        screens[i]:desktopImageURL(fileUrl);
    end;
end

local changeWallpaper = function(imageId)
    changeWallpaperToFile("file://" .. wallpaperResourceDir .. "/" .. imageId .. ".png")
end

local deleteWallpaper = function(imageId)
    os.remove(wallpaperResourceDir .. '/' .. imageId .. '.png');
end

---------------------- End Wallpaper Access


---------------------- Unsplash Wallpaper Integration

local downloadWallpaperFromUnsplash = function(rawImageUrl, callbackFn)
    local customizedImageUrl = rawImageUrl .. '&w=2560&h=1600';
    hs.http.asyncGet(customizedImageUrl, {}, function(responseCode, data, _)
        callbackFn(data);
    end);
end;

local fetchWallpaperImageDetailsFromUnsplash = function(callbackFn)
    local imageCollections = unsplashRelevantCollections[1];
    for i = 2, #unsplashRelevantCollections do
        imageCollections = imageCollections .. ',' .. unsplashRelevantCollections[i];
    end;
    local unsplashUrl = 'https://api.unsplash.com/photos/random?client_id=' .. unsplashApiKey .. '&collections=' .. imageCollections;
    hs.http.asyncGet(unsplashUrl, {}, function(responseCode, rawData, _)
        local imageData = hs.json.decode(rawData);
        callbackFn(imageData.id, imageData.urls.raw);
    end);
end;

local downloadAndChangeWallpaperFromUnsplash = function(callbackFn)
    fetchWallpaperImageDetailsFromUnsplash(function(imageId, imageUrl)
        local fileName = imageId .. ".png";
        downloadWallpaperFromUnsplash(imageUrl, function(data)
            writeToFile(wallpaperResourceDir .. "/" .. fileName, data);
            changeWallpaper(imageId);
            table.insert(wallpaperConfig.wallpapers, imageId);
            wallpaperConfig.currentWallpaperIndex = #wallpaperConfig.wallpapers;
            saveConfig();
            callbackFn(imageId);
        end);
    end);
end

---------------------- End Unsplash Wallpaper Integration


local setPreviousWallpaper = function()
    if wallpaperConfig.currentWallpaperIndex <= 1 then
        hs.alert("Reached earliest wallpaper.");
    else
        local wallpaperId = wallpaperConfig.wallpapers[wallpaperConfig.currentWallpaperIndex - 1];
        changeWallpaper(wallpaperId);
        wallpaperConfig.currentWallpaperIndex = wallpaperConfig.currentWallpaperIndex - 1;
        saveConfig();
    end;
end

local setNextWallpaper = function(performSilent)
    if wallpaperConfig.currentWallpaperIndex == #wallpaperConfig.wallpapers then
        local downloadingWallpaperAlert;
        if not performSilent then
             downloadingWallpaperAlert = hs.alert("Downloading new wallpaper", 30);
        end
        downloadAndChangeWallpaperFromUnsplash(function(_)
            hs.alert.closeSpecific(downloadingWallpaperAlert);
        end);
    else
        local wallpaperId = wallpaperConfig.wallpapers[wallpaperConfig.currentWallpaperIndex + 1];
        changeWallpaper(wallpaperId);
        wallpaperConfig.currentWallpaperIndex = wallpaperConfig.currentWallpaperIndex + 1;
        saveConfig();
    end;
end

local deleteCurrentWallpaper = function()
    if wallpaperConfig.currentWallpaperIndex > 0 then
        deleteWallpaper(wallpaperConfig.wallpapers[wallpaperConfig.currentWallpaperIndex]);
        table.remove(wallpaperConfig.wallpapers, wallpaperConfig.currentWallpaperIndex);
        wallpaperConfig.currentWallpaperIndex = wallpaperConfig.currentWallpaperIndex - 1;
        setNextWallpaper();
    end
end


---------------------- Hotkey Bindings
hs.hotkey.bind({'ctrl', 'shift'}, '[', function()
    setPreviousWallpaper();
end);

hs.hotkey.bind({'ctrl', 'shift'}, ']', function()
    setNextWallpaper(false);
end);

hs.hotkey.bind({'ctrl', 'shift'}, '\\', function()
    deleteCurrentWallpaper();
end);

---------------------- End Hotkey Bindings

hs.timer.doEvery(3600, function() 
    setNextWallpaper(true);
end);