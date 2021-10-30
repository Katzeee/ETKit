//
//  MessageSessionOnWatch.swift
//  ETKit WatchKit Extension
//
//  Created by x on 2021/10/30.
//

import Foundation
import WatchConnectivity

class MessageSessionOnWatch: NSObject, WCSessionDelegate, ObservableObject {
    
    
    var session: WCSession
    @Published var messageText = "default"
    @Published var isOn = false
    
    init(session: WCSession = .default){
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
   //     switch activationState {
   //             case .activated:
   //                 print("WCSession activated successfully")
   //             case .inactive:
   //                 print("Unable to activate the WCSession. Error: \(error?.localizedDescription ?? "--")")
   //             case .notActivated:
   //                 print("Unexpected .notActivated state received after trying to activate the WCSession")
   //             @unknown default:
   //                 print("Unexpected state received after trying to activate the WCSession")
   //             }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {

        DispatchQueue.main.async {
            self.messageText = message["message"] as? String ?? "Unknown"
        }
    }
   
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any])
    {
        DispatchQueue.main.async {
            self.messageText = userInfo["message"] as! String
        }
    }
    
    func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {
        isOn.toggle()
    }
}
