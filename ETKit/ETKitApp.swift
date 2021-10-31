//
//  ETKitApp.swift
//  ETKit
//
//  Created by Xi on 2021/10/15.
//

import SwiftUI
import RealmSwift




@main
struct ETKitApp: SwiftUI.App {

    var dataBaseManager = DataBaseManager() //初始化数据库管理
    var everyDayRefresh = EveryDayRefresh()
    
    let userDefault = UserDefaults.standard
    var currentOpenTime: String?
    var lastOpenTime: String?
    @StateObject var allWordsAndAddWordModel = AllWordsAndAddWordModel()
    

    init() {
        GetOpenTime()
        CheckIsAnotherDay()
    }
    
	
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(allWordsAndAddWordModel)
        }
        #if os(watchOS)
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
        #endif

    }
    
    mutating func GetOpenTime() -> Void {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        //formatter.dateFormat = "yyyy-MM-dd"
        
        lastOpenTime = userDefault.string(forKey: UserInfo().appLastOpenTime)
        currentOpenTime = formatter.string(from: Date())
        userDefault.set(currentOpenTime, forKey: UserInfo().appLastOpenTime)
    }
    
    func CheckIsAnotherDay() -> Void {
        if lastOpenTime! != currentOpenTime! {
            everyDayRefresh.RefreshHasBeenReviewedTodayState()
            everyDayRefresh.RefreshNextTimeReviewInterval()
        }
    }
}
