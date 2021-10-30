//
//  MessageSessionOnPhone.swift
//  ETKit
//
//  Created by x on 2021/10/30.
//

import Foundation
import WatchConnectivity

class MessageSessionOnPhone: NSObject, ObservableObject, WCSessionDelegate {
    
    
    @Published var messageText = ""
    var session: WCSession
    init(session: WCSession = .default){
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        replyHandler(["Phone" : "Get"])
        DispatchQueue.main.async {
            self.messageText = message["message"] as? String ?? "Unknown"
        }
    }
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    #endif
    
    
    
}


