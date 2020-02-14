-- Helper for Launching App
launch = function(app)
    hs.application.launchOrFocusByBundleID(app.bundleID)
end

for _, app in pairs(config.applications) do
    if app.f20Shortcut then
        f20:bind({}, app.f20Shortcut, function() launch(app); end)
    end
end