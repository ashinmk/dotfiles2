local outlookF20Modal = hs.hotkey.modal.new({}, nil);

f20:registerAppSpecificSubModal('Microsoft Outlook', outlookF20Modal);

outlookModal = hs.hotkey.modal.new({}, nil)

outlookModalFilter = hs.window.filter.new{'Microsoft Outlook'};
outlookModalFilter:subscribe(hs.window.filter.windowFocused, function()
    outlookModal:enter();
end)
outlookModalFilter:subscribe(hs.window.filter.windowUnfocused, function()
    outlookModal:exit();
end)

local folder_bindings = {
    {
        folder = 'Inbox',
        parentFolder = '',
        bindings = {
            {
                action = 'navigate_to',
                mods = {"cmd", "shift"},
                key = 'I',
                f20 = false
            }
        }
    },
    {
        folder = 'Drafts',
        parentFolder = '',
        bindings = {
            {
                action = 'navigate_to',
                mods = {"cmd", "shift"},
                key = 'D',
                f20 = false
            }
        }
    },
    {
        folder = 'Sent Items',
        parentFolder = '',
        bindings = {
            {
                action = 'navigate_to',
                mods = {"cmd", "shift"},
                key = 'S',
                f20 = false
            }
        }
    },
    {
        folder = '1-Immediate',
        parentFolder = 'Inbox',
        bindings = {
            {
                action = 'navigate_to',
                mods = {"cmd", "shift"},
                key = '1',
                f20 = false
            },
            {
                action = 'move_message_to_folder',
                mods = {"alt"},
                key = '1',
                f20 = false
            }
        }
    },
    {
        folder = '2-Followup',
        parentFolder = 'Inbox',
        bindings = {
            {
                action = 'navigate_to',
                mods = {"cmd", "shift"},
                key = '2',
                f20 = false
            },
            {
                action = 'move_message_to_folder',
                mods = {"alt"},
                key = '2',
                f20 = false
            }
        }
    },
    {
        folder = '3-Wait For Reply',
        parentFolder = 'Inbox',
        bindings = {
            {
                action = 'navigate_to',
                mods = {"cmd", "shift"},
                key = '3',
                f20 = false
            },
            {
                action = 'move_message_to_folder',
                mods = {"alt"},
                key = '3',
                f20 = false
            }
        }
    },
    {
        folder = '4-Review',
        parentFolder = 'Inbox',
        bindings = {
            {
                action = 'navigate_to',
                mods = {"cmd", "shift"},
                key = '4',
                f20 = false
            },
            {
                action = 'move_message_to_folder',
                mods = {"alt"},
                key = '4',
                f20 = false
            }
        }
    },
    {
        folder = '5-Delete Soon',
        parentFolder = 'Inbox',
        bindings = {
            {
                action = 'navigate_to',
                mods = {"cmd", "shift"},
                key = '5',
                f20 = false
            },
            {
                action = 'move_message_to_folder',
                mods = {"alt"},
                key = '5',
                f20 = false
            }
        }
    },
    {
        folder = '6-CR to me',
        parentFolder = 'Inbox',
        bindings = {
            {
                action = 'navigate_to',
                mods = {"cmd", "shift"},
                key = '6',
                f20 = false
            }
        }
    }
}

local setup_navigate_to_binding = function(record, binding, targetModal)
    targetModal:bind(binding.mods, binding.key, function()
        runLocalScript('outlook_navigate_to_folder.applescript', {targetFolder = record.folder, parentFolder = record.parentFolder});
    end)
end

local setup_move_message_to_folder_binding = function(record, binding, targetModal)
    targetModal:bind(binding.mods, binding.key, function()
        runLocalScript('outlook_move_to_folder.applescript', {targetFolder = record.folder, parentFolder = record.parentFolder});
    end)
end

local action_bindings = {
    move_message_to_folder = setup_move_message_to_folder_binding,
    navigate_to = setup_navigate_to_binding
}

for _, record in pairs(folder_bindings) do
    for _, binding in pairs(record.bindings) do
        if binding.f20 then
            targetModal = outlookF20Modal;
        else
            targetModal = outlookModal;
        end
        action_bindings[binding.action](record, binding, targetModal);
    end
end

outlookModal:bind({"cmd", "ctrl"}, 'S', function()
    runLocalScript('outlook_save_message.js', {});
end)