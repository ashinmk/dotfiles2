local f20 = hs.hotkey.modal.new({}, nil);

f20.registeredSubModals = {};

function f20:registerSubModal(id, modal)
    f20.registeredSubModals[id] = modal;
end

function f20:unregisterSubModal(id)
    if f20.registeredSubModals[id] then
        f20.registeredSubModals[id]:exit() -- To handle race-conditions in unregistering vs release
        f20.registeredSubModals[id] = nil;
    end
end

f20.appWindowFilters = {};

function f20:registerAppSpecificSubModal(appName, modal)
    appWindowFilter = hs.window.filter.new{appName};
    appWindowFilter:subscribe(hs.window.filter.windowFocused, function()
        f20:registerSubModal(appName, modal);
    end)
    appWindowFilter:subscribe(hs.window.filter.windowUnfocused, function()
        f20:unregisterSubModal(appName);
    end)
    f20.appWindowFilters[appName] = appWindowFilter;
end

function f20:unregisterAppSpecificSubModal(appName)
    if f20.appWindowFilters[appName] then
        f20.appWindowFilters[appName]:pause();
        f20.appWindowFilters[appName] = nil
    end
    f20.unregisterSubModal(appName);
end

local pressedf20 = function()
    f20:enter();
    for _, modal in pairs(f20.registeredSubModals) do
        modal:enter();
    end
end

local releasedf20 = function()
    f20:exit();
    for _, modal in pairs(f20.registeredSubModals) do
        modal:exit();
    end
end

hs.hotkey.bind({}, 'F20', pressedf20, releasedf20);

return f20;