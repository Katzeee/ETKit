//
//  ETKitApp.swift
//  ETKit WatchKit Extension
//
//  Created by x on 2021/10/30.
//

import SwiftUI

@main
struct WatchConnectivityApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
