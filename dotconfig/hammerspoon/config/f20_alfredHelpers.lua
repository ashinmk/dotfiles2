function triggerAlfredWorkflow(trigger, workflow, arg)
    local script = 'tell application id "com.runningwithcrayons.Alfred" to run trigger "' .. trigger .. '" in workflow "' .. workflow .. '"';
    if arg ~= nil then
        script = script .. 'with argument "' .. arg .. '"';
    end
    hs.osascript.applescript(script);
end

config.alfredTriggers = {
    {
        trigger = 'open-app',
        arg = 'alfred',
        workflow = 'dev.gauthamw.open-stuff',
        f20Shortcut = 'a',
        postTrigger = function()
            hs.eventtap.keyStroke({}, "return")
        end
    },
    {
        trigger = 'open-app',
        arg = 'discord',
        workflow = 'dev.gauthamw.open-stuff',
        f20Shortcut = 'd'
    },
    {
        trigger = 'open-app',
        arg = 'slack',
        workflow = 'dev.gauthamw.open-stuff',
        f20Shortcut = 'm'
    },
    {
        trigger = 'open-app',
        arg = 'outlook',
        workflow = 'dev.gauthamw.open-stuff',
        f20Shortcut = 'm',
        f20Modifiers = {'shift'}
    },
    {
        trigger = 'open-app',
        arg = 'iterm',
        workflow = 'dev.gauthamw.open-stuff',
        f20Shortcut = 't'
    },
    {
        trigger = 'open-app',
        arg = 'chrome',
        workflow = 'dev.gauthamw.open-stuff',
        f20Shortcut = 'c'
    },
    {
        trigger = 'open-chrome-tabs',
        workflow = 'com.bit2pixel.chromecontrol',
        f20Shortcut = 'c',
        f20Modifiers = {'shift'}
    },
    {
        trigger = 'open-app',
        arg = 'chime',
        workflow = 'dev.gauthamw.open-stuff',
        f20Shortcut = 'm',
        f20Modifiers = {'alt'}
    },
    {
        trigger = 'open-app',
        arg = 'intellij',
        workflow = 'dev.gauthamw.open-stuff',
        f20Shortcut = 'i'
    },
    {
        trigger = 'open-app',
        arg = 'postman',
        workflow = 'dev.gauthamw.open-stuff',
        f20Shortcut = 'p'
    },
    {
        trigger = 'open-app',
        arg = 'vs-code',
        workflow = 'dev.gauthamw.open-stuff',
        f20Shortcut = 'v'
    },
    {
        trigger = 'open-app',
        arg = 'vs-code-notes',
        workflow = 'dev.gauthamw.open-stuff',
        f20Shortcut = 'v',
        f20Modifiers = {'shift'}
    },
    {
        trigger = 'spotify',
        workflow = 'dev.gauthamw.open-stuff',
        f20Shortcut = 's'
    },
    {
        trigger = 'emoji-picker',
        workflow = 'com.github.jsumners.alfred-emoji',
        f20Shortcut = 'e'
    }
};


for _, alfredTrigger in pairs(config.alfredTriggers) do
    local modifiers = {};
    if alfredTrigger.f20Modifiers then
        modifiers = alfredTrigger.f20Modifiers;
    end
    if alfredTrigger.f20Shortcut then
        f20:bind(modifiers, alfredTrigger.f20Shortcut, function()
            triggerAlfredWorkflow(alfredTrigger.trigger, alfredTrigger.workflow, alfredTrigger.arg)
            if alfredTrigger.postTrigger then
                alfredTrigger.postTrigger()
            end
        end)
    end
end
