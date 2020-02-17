local appleScriptDir = hs.configdir.. "/applescript/";

function runLocalScript(fileName, args)
    return runScript(appleScriptDir .. fileName, args);
end

function runScript(fileName, args)
    local script = getScript(fileName, args);
    if string.match(fileName, ".applescript$") then
        return hs.osascript.applescript(script);
    elseif string.match(fileName, ".js$") then
        return hs.osascript.javascript(script);
    end
end

function getScript(fileName, args)
    local scriptTemplate = readFileContents(fileName);
    for key, value in pairs(args) do
        scriptTemplate, _ = string.gsub(scriptTemplate, "{{{" ..key.. "}}}", value);
    end
    return scriptTemplate;
end