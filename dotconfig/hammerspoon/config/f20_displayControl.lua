local displayBrightnessModal = hs.hotkey.modal.new({}, nil);

local displayBrightnessModalEnabled = false;
local monitorBeingUpdated = 1;
local displayBrightnessUpdatedModel = nil;

displayBrightnessModal:bind({}, '1', function()
    monitorBeingUpdated = 1;
    hs.alert.show("Controlling monitor " .. monitorBeingUpdated);
end);
displayBrightnessModal:bind({}, '2', function()
    monitorBeingUpdated = 2;
    hs.alert.show("Controlling monitor " .. monitorBeingUpdated);
end);
displayBrightnessModal:bind({}, 'up', function()
    setBrightness(monitorBeingUpdated, "10+");
end);
displayBrightnessModal:bind({}, 'down', function()
    setBrightness(monitorBeingUpdated, "10-");
end);

function setBrightness(displayNumber, brightness)
    local newBrightness = hs.execute("/usr/local/bin/ddcctl" .. " -d " .. displayNumber .. " -b " .. brightness  .. " | grep 'setting VCP' | cut -d '>' -f 2 ");
    hs.alert.closeSpecific(displayBrightnessUpdatedModel);
    displayBrightnessUpdatedModel = hs.alert.show("Brightness set to " .. newBrightness);
end

f20:bind({"shift"}, 'b', function()
    if (displayBrightnessModalEnabled) then
        displayBrightnessModal:exit();
        displayBrightnessModalEnabled = false;
        hs.alert.show("Exiting Brightness Control");
    else
        displayBrightnessModal:enter();
        displayBrightnessModalEnabled = true;
        hs.alert.show("Controlling monitor " .. monitorBeingUpdated);
    end
end);
