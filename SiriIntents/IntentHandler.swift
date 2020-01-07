//
//  IntentHandler.swift
//  SiriIntents
//
//  Created by Remy Kabel on 22/08/2019.
//

import Intents


@available(iOS 12.0, *)
class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is ActivateButtonIntent else {
            fatalError("Unhandled intent type: \(intent)")
        }
        
        return ActivateButtonIntentHandler()

    }
}
