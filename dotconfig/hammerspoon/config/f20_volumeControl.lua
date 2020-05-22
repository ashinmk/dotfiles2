local micMuteToggleAlert = nil;
local outputMuteToggleAlert = nil;

-- Input Mute Toggle
f20:bind({}, '-', function()
    if micMuteToggleAlert then
        hs.alert.closeSpecific(micMuteToggleAlert);
        micMuteToggleAlert = nil;
    end
    local inputDevice = hs.audiodevice.defaultInputDevice();
    local isMuted = inputDevice:inputMuted();
    local alertMessage;
    if isMuted then
        alertMessage = "Mic Un-muted";
        inputDevice:setInputMuted(false);
    else
        alertMessage = "Mic Muted";
        inputDevice:setInputMuted(true);
    end
    micMuteToggleAlert = hs.alert.show(alertMessage);
end)

-- Output Mute Toggle
f20:bind({}, '=', function()
    if outputMuteToggleAlert then
        hs.alert.closeSpecific(outputMuteToggleAlert);
        outputMuteToggleAlert = nil;
    end
    local outputDevice = hs.audiodevice.defaultOutputDevice();
    local isMuted = outputDevice:outputMuted();
    local alertMessage;
    if isMuted then
        alertMessage = "Sound Un-muted";
        outputDevice:setOutputMuted(false);
    else
        alertMessage = "Sound Muted";
        outputDevice:setOutputMuted(true);
    end
    outputMuteToggleAlert = hs.alert.show(alertMessage);
end)

local headPhoneIdentifier = "WH-1000XM3";
local builtInInputIdentifier = "Built-in Microphone";
local builtInOutputIdentifier = "Built-in Output";

-- Change Audio Device to Headphone
f20:bind({}, '[', function()
    local inputDevice = hs.audiodevice.findInputByName(headPhoneIdentifier);
    local outputDevice = hs.audiodevice.findOutputByName(headPhoneIdentifier);    

    if inputDevice and outputDevice then
        inputDevice:setDefaultInputDevice();
        outputDevice:setDefaultOutputDevice();
        hs.alert.show("Changed Audio Device to headphones");
    else
        hs.alert.show("Failed to change audio device to headphones");
    end
end)

-- Change Audio Device to Built-In
f20:bind({}, ']', function()
    hs.audiodevice.findInputByName(builtInInputIdentifier):setDefaultInputDevice();
    hs.audiodevice.findOutputByName(builtInOutputIdentifier):setDefaultOutputDevice();
    hs.alert.show("Changed Audio Device to Built-In");
end)

function getDeviceInfo(device)
    local deviceInfo = nil;
    if device:isInputDevice() then
        deviceInfo = "Input Device: " .. device:name();
        if device:inputMuted() then
            deviceInfo = deviceInfo .. " [Muted]";
        else
            deviceInfo = deviceInfo  .. " [" .. math.floor(device:inputVolume()) .. "]";
        end
    else
        deviceInfo = "Output Device: " .. device:name();
        if device:outputMuted() then
            deviceInfo = deviceInfo .. " [Muted]";
        else
            deviceInfo = deviceInfo  .. " [" .. math.floor(device:outputVolume()) .. "]";
        end
    end
    return deviceInfo;
end

-- Sound Status
f20:bind({}, '\\', function()
    hs.alert.show(getDeviceInfo(hs.audiodevice.defaultInputDevice()) .. "\n" .. getDeviceInfo(hs.audiodevice.defaultOutputDevice()));
end)