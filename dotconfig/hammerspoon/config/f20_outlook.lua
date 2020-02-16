local folder_movement_bindings = {
    {
        key = '1',
        targetFolder = '1-Immediate',
        parentFolder = 'Inbox'
    },
    {
        key = '2',
        targetFolder = '2-Followup',
        parentFolder = 'Inbox'
    },
    {
        key = '3',
        targetFolder = '3-Wait For Reply',
        parentFolder = 'Inbox'
    },
    {
        key = '4',
        targetFolder = '4-Review',
        parentFolder = 'Inbox'
    },
    {
        key = '5',
        targetFolder = '5-Delete Soon',
        parentFolder = 'Inbox'
    }
}

local outlookModal = hs.hotkey.modal.new({}, nil);

for _, binding in pairs(folder_movement_bindings) do
    outlookModal:bind({}, binding.key, function()
        runLocalScript('outlook_move_to_folder.applescript', {targetFolder = binding.targetFolder, parentFolder = binding.parentFolder});
    end)
end

f20:registerAppSpecificSubModal('Microsoft Outlook', outlookModal);