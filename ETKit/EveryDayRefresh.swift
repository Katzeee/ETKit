//
//  EveryDayRefresh.swift
//  ETKit
//
//  Created by x on 2021/10/29.
//

import Foundation
import RealmSwift

class EveryDayRefresh {
    let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func RefreshHasBeenReviewedTodayState() -> Void {
        let results = realm.objects(Word.self)
        
        try! realm.write {
            results.setValue(false, forKey: "hasBeenReviewedToday")
        }
    }
    func RefreshNextTimeReviewInterval() -> Void {
        let results = realm.objects(Word.self)
        
        try! realm.write {
            for word in results.filter("nextTimeReviewInterval > 0") {
                    word.nextTimeReviewInterval -= 1
            }
        }
    }
}
