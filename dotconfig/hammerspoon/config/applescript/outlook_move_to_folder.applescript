tell application "Microsoft Outlook"
    set msgSet to selected objects
    if msgSet = {} then
        error "No messages selected. Select at least one message."
        error -128
    end if
    set sampleMessage to item 1 of msgSet
    set theAccount to account of sampleMessage
    set targetFolder to folder "{{{targetFolder}}}" of folder "{{{parentFolder}}}" of theAccount
    repeat with selectedMessage in msgSet
        move selectedMessage to targetFolder
    end repeat
end tell