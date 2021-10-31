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
    @Published var allWords: [WordForWatch] = [WordForWatch(word: "nnnn")]
    @Published var oneword = ["chushi"]
    
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
            //self.allWords = message["allWords"] as? [WordForWatch] ?? []
        }
    }
    
     func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        replyHandler(["Phone" : "Get"])
        DispatchQueue.main.async {
            self.messageText = message["message"] as? String ?? "Unknown"
        }
    }
    
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any])
    {
        print("userInfo")
        print(userInfo)
        //print("type of:\(type(of: userInfo["allWords"]))")
        DispatchQueue.main.async {
            self.messageText = userInfo["message"] as? String ?? "Unknown"

            /*if case let m = Mirror(reflecting: userInfo["allWords"]) where (m.displayStyle ?? .struct) == .collection {
                let arr = m.children.map { $0.value }
                self.allWords = arr
            }*/
            self.allWords = userInfo["allWords"] as? [WordForWatch] ?? [WordForWatch(word: "转不了")]
            self.oneword = userInfo["oneWord"] as? [String] ?? ["nodui"]
        }
    }
    
    func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {
        
    }
    
    private func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        print(applicationContext)
        DispatchQueue.main.async {
            self.allWords = applicationContext["allWords"] as? [WordForWatch] ?? [WordForWatch(word: "转不了")]
        }
    }
    
    //func session(_ session: WCSession, )
}
