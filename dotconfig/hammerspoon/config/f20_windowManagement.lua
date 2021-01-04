hs.loadSpoon("Lunette");

customBindings = {
    leftHalf = false,
    rightHalf = false,
    topHalf = false,
    bottomHalf = false,
    topLeft = false,
    topRight = false,
    bottomLeft = false,
    bottomRight = false,
    fullScreen = false,
    center = false,
    nextThird = false,
    prevThird = false,
    enlarge = false,
    shrink = false,
    undo = false,
    redo = false,
    nextDisplay = false,
    prevDisplay = false
}

spoon.Lunette:bindHotkeys(customBindings)
f20:bind({'alt'}, 'left', function()
    spoon.Lunette:exec('leftHalf')
end)
f20:bind({'alt'}, 'right', function()
    spoon.Lunette:exec('rightHalf')
end)
f20:bind({'alt'}, 'up', function()
    spoon.Lunette:exec('topHalf')
end)
f20:bind({'alt'}, 'down', function()
    spoon.Lunette:exec('bottomHalf')
end)
f20:bind({"shift"}, 'left', function()
    spoon.Lunette:exec('prevDisplay')
end)
f20:bind({"shift"}, 'right', function()
    spoon.Lunette:exec('nextDisplay')
end)
f20:bind({}, 'space', function()
    hs.window.focusedWindow():toggleFullScreen();
end)
