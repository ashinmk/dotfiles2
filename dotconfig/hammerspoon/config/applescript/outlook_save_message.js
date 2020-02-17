const app = Application('Microsoft Outlook');
app.includeStandardAdditions = true

let selectedMessages = app.selectedObjects();
if (selectedMessages.length == 0) {
    console.log("No selected messages");
} else {
    for (let i = 0; i < selectedMessages.length; ++i) {
        let selectedMessage = selectedMessages[i];
        let subject = selectedMessage.subject();
        let fileName = app.chooseFileName({ withPrompt: "Save as EML", defaultName: subject.replace(/\//g, "_") + ".eml" });
        selectedMessage.save({ in: Path(fileName) });
    }
}
