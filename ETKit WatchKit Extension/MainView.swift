//
//  MainView.swift
//  ETKit WatchKit Extension
//
//  Created by Xi on 2021/10/15.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var model = MessageSessionOnWatch()
    
    var body: some View {
        
        //DairyTestView()
        VStack(spacing: 10) {
            Text("AllWords")
            Text(model.messageText)
            List(model.allWords) { wordItem in
                Text(wordItem.word)
            }
        }
        
    }
}


struct DairyTestView: View {
    
    @ObservedObject var model = MessageSessionOnWatch()
    @State var reachable = "No"
    @State var messageText = ""
    var body: some View {
        ScrollView {
            Toggle("isOn", isOn: $model.isOn)
            if model.isOn {
                Text(model.messageText)
            }
            Text("Reachable \(reachable)")
            
            Button(action: {
                if self.model.session.isReachable{
                    self.reachable = "Yes"
                }
                else{
                    self.reachable = "No"
                }
                
            }) {
                Text("Update")
            }
            VStack{
                Text("phone:\(model.messageText)")
                TextField("Input your message", text: $messageText)
                Button(action: {
                    self.model.session.sendMessage(["message" : self.messageText], replyHandler: {(replyMessage) in print(replyMessage)}) { (error) in
                        print(error.localizedDescription)
                    }
                }, label: {Text("sendMessage")})
                
                Button(action: {
                    self.model.session.sendMessage([:], replyHandler: {(replyMessage) in print(replyMessage)}) { (error) in
                        print(error.localizedDescription)
                    }
                }, label: {Text("getMessage")})
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
