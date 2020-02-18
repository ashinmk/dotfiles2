-- Reload HammerSpoon Config
f20:bind({}, '[', function()
    hs.reload();
end)

-- Clear HammerSpoon Console
f20:bind({}, ']', function()
    hs.console.clearConsole();
end)

f20:bind({}, '\\', function()
    hs.alert(hs.application.frontmostApplication():name());
end)

f20:bind({"shift"}, '\\', function()
    hs.alert(hs.application.frontmostApplication():bundleID());
end)