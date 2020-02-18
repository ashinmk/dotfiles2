configloadingAlert = hs.alert.show("Loading HammerSpoon Config");

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
        bundleID = 'com.toggl.toggldesktop.TogglDesktop',
        f20Shortcut = 'tab'
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
require 'fs_helpers';
require 'applescript.helpers';
f20 = require 'f20';

require 'f20_general'
require 'f20_launchApps'
require 'f20_windowManagement'
require 'f20_outlook'

require 'wallpaper_control'

hs.alert.closeSpecific(configloadingAlert);
hs.alert("Loaded HammerSpoon Config");
hs.console.clearConsole();