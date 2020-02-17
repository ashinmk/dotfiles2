tell application "Microsoft Outlook"
	set theAccount to the first exchange account
	set targetFolder to "{{{targetFolder}}}"
	set parentFolder to "{{{parentFolder}}}"
	if parentFolder = "" then
		set selected folder to folder targetFolder of theAccount
	else
		set selected folder to folder targetFolder of folder parentFolder of theAccount
	end if
end tell