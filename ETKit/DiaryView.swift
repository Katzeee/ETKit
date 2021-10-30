//
//  DiaryView.swift
//  ETKit
//
//  Created by Xi on 2021/10/16.
//

import SwiftUI

struct DiaryView: View {
    
    @ObservedObject var model = MessageSessionOnPhone()
    @State var reachable = "No"
    @State var messageText = "111"
    var body: some View {
        VStack{
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
            Text("message from watch: \(model.messageText)")
            TextField("Input your message", text: $messageText).padding()
            Button(action: {
                if model.session.isReachable {
                    self.model.session.sendMessage(["message" : self.messageText], replyHandler: nil) { (error) in
                        print(error.localizedDescription)
                    }
                } else {
                    print("not reachable")
                }
                
                
            }
                   , label: {Text("sendMessage")})
        }
        
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView()
    }
}
