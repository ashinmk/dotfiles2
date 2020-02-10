config = {}

config.applications = {
    {
        bundleID = 'com.runningwithcrayons.Alfred',
        f20Shortcut = 'a'
    },
    {
        bundleID = 'com.googlecode.iterm2',
        f20Shortcut = 't'
    },
    {
        bundleID = 'com.google.Chrome',
        f20Shortcut = 'c'
    },
    {
        bundleID = 'com.amazon.Amazon-Chime',
        f20Shortcut = 'm'
    },
    {
        bundleID = 'com.microsoft.Outlook',
        f20Shortcut = 'o'
    },
    {
        bundleID = 'com.jetbrains.intellij',
        f20Shortcut = 'i'
    },
    {
        bundleID = 'com.postmanlabs.mac',
        f20Shortcut = 'p'
    },
    {
        bundleID = 'com.spotify.client',
        f20Shortcut = 's'
    },
    {
        bundleID = 'com.microsoft.VSCode',
        f20Shortcut = 'v'
    },
    {
        bundleID = 'com.stairways.keyboardmaestro.editor',
        f20Shortcut = 'k'
    }
}

launch = function(app)
    hs.application.launchOrFocusByBundleID(app.bundleID)
end

f20 = require 'f20';
require 'f20_launchApps'

-- Reload HammerSpoon Config
f20:bind({}, 'R', function()
    hs.reload();
end)