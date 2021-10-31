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
    @Published var allWords: [WordForWatch] = []
    @Published var oneword = ["chushi"]
    var allWordsJson: [Data] = []
    
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
        //print("userInfo")
        //print(userInfo)
        self.allWords = []
        DispatchQueue.main.async {
            
            self.messageText = userInfo["message"] as? String ?? "Unknown"
            self.allWordsJson = userInfo[KeysOfSharedObjects.allWords.rawValue] as? [Data] ?? []
            self.oneword = userInfo["oneWord"] as? [String] ?? ["nodui"]
        }
        
        //print(self.allWordsJson)
        for wordJson in self.allWordsJson {
            do {
                let wordDecoded = try wordJson.decoded() as WordForWatch
                self.allWords.append(wordDecoded)
            } catch {
                print(error)
            }
        }
    }
    
    func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {
        
    }
    
    private func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        
    }
    
    //func session(_ session: WCSession, )
}
