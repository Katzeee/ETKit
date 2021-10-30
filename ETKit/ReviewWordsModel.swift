//
//  ReviewWordsModel.swift
//  ETKit
//
//  Created by Xi on 2021/10/21.
//

import Foundation
import RealmSwift


class ReviewWordsModel: ObservableObject {
	
	let realm = try! Realm()
	@Published var AllWordsToReview: [Word] = []
	
	func GetReviewWords() -> Void {
		let results = realm.objects(Word.self).filter("hasDoneLearning = false AND hasBeenReviewedToday = false AND nextTimeReviewInterval = 0").sorted(byKeyPath: "learningTimes")
		AllWordsToReview = results.compactMap({ (word) -> Word? in
			return word
		})
	}
    
    //认识
    func RememberWord(_ word: Word) -> Void {
        let index = FindIndexByWordItem(word)
        AllWordsToReview.remove(at: index)
        try! realm.write {
            word.hasBeenReviewedToday = true
            word.rememberTimes += 1
            word.learningTimes += 1
            SetEFValue(word, 5.0)
            SetNextTimeReviewInterval(word)
        }
        
    }
    
    //不认识
    func CannotRememberWord(_ word: Word) -> Void {
        let index = FindIndexByWordItem(word)
        AllWordsToReview.remove(at: index)
        try! realm.write {
            word.hasBeenReviewedToday = true
            word.cannotRememberTimes += 1
            word.learningTimes += 1
            SetEFValue(word, 1.0)
            SetNextTimeReviewInterval(word)
        }
    }

    //不用复习了
    func HaveLearnedWord(_ word: Word) -> Void {
        let index = FindIndexByWordItem(word)
        AllWordsToReview.remove(at: index)
        try! realm.write {
            word.hasDoneLearning = true
        }
    }
    
    //重设EF值
    func SetEFValue(_ word: Word, _ q: Float) -> Void {
        word.EFValue = word.EFValue - 0.8 + 0.28 * q - 0.02 * q * q
        if word.EFValue < 1.3 {
            word.EFValue = 1.3
        }
    }
    
    //重设下次复习间隔
    func SetNextTimeReviewInterval(_ word: Word) -> Void {
        if word.learningTimes == 1 {
            word.nextTimeReviewInterval = 6
            word.nextTimeReviewIntervalRecord = 6
        } else {
            word.nextTimeReviewIntervalRecord = Int(Float(word.nextTimeReviewIntervalRecord) * word.EFValue)
            word.nextTimeReviewInterval = word.nextTimeReviewIntervalRecord
        }
    }
    
    func FindIndexByWordItem(_ word: Word) -> Int {
        for i in 0..<AllWordsToReview.count {
            if AllWordsToReview[i] == word {
                return i
            }
        }
        return -1 //Search Fail
    }
    
    
	init() {
		GetReviewWords()
	}
}
