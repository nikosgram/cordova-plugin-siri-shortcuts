import Intents
import IntentsUI

class ShortcutPresentedDelegate: NSObject, INUIAddVoiceShortcutViewControllerDelegate, INUIEditVoiceShortcutViewControllerDelegate {
    let command: CDVInvokedUrlCommand
    let shortcuts: SiriShortcuts

    init(command: CDVInvokedUrlCommand, shortcuts: SiriShortcuts) {
        self.command = command
        self.shortcuts = shortcuts
    }

    @available(iOS 12.0, *)
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController,
                                        didFinishWith voiceShortcut: INVoiceShortcut?,
                                        error: Error?) {
        if let error = error as NSError? {
            self.shortcuts.sendStatusError(self.command, error: "Internal error occured: " + error.localizedDescription)
            return
        }

        let returnData = [
            "invocationPhrase": voiceShortcut?.invocationPhrase,
            "uuid": voiceShortcut?.identifier.uuidString,
        ]

        self.shortcuts.send(pluginResult: CDVPluginResult(
            status: CDVCommandStatus_OK,
            messageAs: returnData as [AnyHashable: Any]
            ), command: command)

        controller.dismiss(animated: true)
    }

    @available(iOS 12.0, *)
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        self.shortcuts.sendStatusError(self.command, error: "Siri shortcut dismissed.")

        controller.dismiss(animated: true)
    }

    @available(iOS 12.0, *)
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        if let error = error as NSError? {
            self.shortcuts.sendStatusError(self.command, error: "Internal error occured: " + error.localizedDescription)
            return
        }

        let returnData = [
            "invocationPhrase": voiceShortcut?.invocationPhrase,
            "uuid": voiceShortcut?.identifier.uuidString,
        ]

        self.shortcuts.send(pluginResult: CDVPluginResult(
            status: CDVCommandStatus_OK,
            messageAs: returnData as [AnyHashable: Any]
        ), command: command)

        controller.dismiss(animated: true)
    }

    @available(iOS 12.0, *)
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        let returnData = [
            "invocationPhrase": "",
            "uuid": "",
        ]

        self.shortcuts.send(pluginResult: CDVPluginResult(
            status: CDVCommandStatus_OK,
            messageAs: returnData as [AnyHashable: Any]
        ), command: command)

        controller.dismiss(animated: true)
    }

    @available(iOS 12.0, *)
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        self.shortcuts.sendStatusError(self.command, error: "Siri shortcut dismissed.")

        controller.dismiss(animated: true)
    }
}