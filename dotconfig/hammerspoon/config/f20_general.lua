-- Reload HammerSpoon Config
f20:bind({'cmd', 'shift'}, '[', function()
    hs.reload();
end)

-- Clear HammerSpoon Console
f20:bind({'cmd', 'shift'}, ']', function()
    hs.console.clearConsole();
end)

f20:bind({'cmd', 'shift'}, '\\', function()
    local appInfo = "Name:  " .. hs.application.frontmostApplication():name();
    appInfo = appInfo .. '\n' .. "BundleId:  " .. hs.application.frontmostApplication():bundleID();
    hs.pasteboard.setContents(appInfo);
    hs.alert(appInfo);
end)