configloadingAlert = hs.alert.show("Loading HammerSpoon Config");

config = {}


require 'fs_helpers';
require 'applescript.helpers';
f20 = require 'f20';

require 'f20_general'
require 'f20_windowManagement'
require 'f20_outlook'
require 'f20_volumeControl'
require 'f20_alfredHelpers';
require 'wallpaper_control'

hs.alert.closeSpecific(configloadingAlert);
hs.alert("Loaded HammerSpoon Config");
hs.console.clearConsole();