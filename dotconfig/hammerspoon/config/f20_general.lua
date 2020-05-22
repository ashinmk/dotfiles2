-- Reload HammerSpoon Config
f20:bind({'cmd', 'shift'}, '[', function()
    hs.reload();
end)

-- Clear HammerSpoon Console
f20:bind({'cmd', 'shift'}, ']', function()
    hs.console.clearConsole();
end)

f20:bind({'cmd', 'shift'}, '\\', function()
    hs.alert("Name:  " .. hs.application.frontmostApplication():name());
    hs.alert("BundleId:  " .. hs.application.frontmostApplication():bundleID());
end)