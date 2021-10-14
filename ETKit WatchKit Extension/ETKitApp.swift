//
//  ETKitApp.swift
//  ETKit WatchKit Extension
//
//  Created by Xi on 2021/10/15.
//

import SwiftUI

@main
struct ETKitApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
