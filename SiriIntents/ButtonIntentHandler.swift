//
//  ButtonIntentHandler.swift
//  Olisto
//
//  Created by Remy Kabel on 22/08/2019.
//

import Foundation

class ActivateButtonIntentHandler: NSObject, ActivateButtonIntentHandling {
    @available(iOS 12.0, *)
    func handle(intent: ActivateButtonIntent, completion: @escaping (ActivateButtonIntentResponse) -> Void) {
        guard let sharedData = loadSharedData(), sharedData.isDefined() else {
            completion(ActivateButtonIntentResponse(code: .failureRequiringAppLaunch, userActivity: nil))
            return
        }
        
        let url = "\(sharedData.baseUrl!)/channel/triggi-buttons/push/\(intent.id!)"
        
        postCall(url, token: sharedData.token!, completionHandler: {(statusCode: Int?) -> () in
            print("Call executed with status code: \(statusCode!)")
            
            if (statusCode != nil) && statusCode! >= 200 && statusCode! < 300 {
                completion(ActivateButtonIntentResponse(code: .success, userActivity: nil))
            } else {
                completion(ActivateButtonIntentResponse(code: .failure, userActivity: nil))
            }
        })
    }
}
