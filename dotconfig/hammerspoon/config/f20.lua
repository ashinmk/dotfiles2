local f20 = hs.hotkey.modal.new({}, nil);
local pressedf20 = function()
    f20:enter();
end

local releasedf20 = function()
    f20:exit();
end

hs.hotkey.bind({}, 'F20', pressedf20, releasedf20);

return f20;