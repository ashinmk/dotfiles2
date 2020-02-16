local appleScriptDir = hs.configdir.. "/applescript/";

function runLocalScript(fileName, args)
    return runScript(appleScriptDir .. fileName, args);
end

function runScript(fileName, args)
    local script = getScript(fileName, args);
    return hs.osascript.applescript(script);
end

function getScript(fileName, args)
    local scriptTemplate = readFileContents(fileName);
    for key, value in pairs(args) do
        scriptTemplate, _ = string.gsub(scriptTemplate, "{{{" ..key.. "}}}", value);
    end
    return scriptTemplate;
end