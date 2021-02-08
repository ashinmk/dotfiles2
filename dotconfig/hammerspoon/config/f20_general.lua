-- Reload HammerSpoon Config
f20:bind({}, '[', function()
    hs.reload();
end)

-- Clear HammerSpoon Console
f20:bind({}, ']', function()
    hs.console.clearConsole();
end)

f20:bind({}, '\\', function()
    local appInfo = "Name:  " .. hs.application.frontmostApplication():name();
    appInfo = appInfo .. '\n' .. "BundleId:  " .. hs.application.frontmostApplication():bundleID();
    hs.pasteboard.setContents(appInfo);
    hs.alert(appInfo);
end)

f20:bind({}, 'escape', function()
    hs.caffeinate.startScreensaver();
end)
