-- Reload HammerSpoon Config
f20:bind({}, '[', function()
    hs.reload();
end)

-- Clear HammerSpoon Console
f20:bind({}, ']', function()
    hs.console.clearConsole();
end)
