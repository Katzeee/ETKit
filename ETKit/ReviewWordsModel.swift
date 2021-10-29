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
		let results = realm.objects(Word.self).filter("hasDoneLearning = false AND hasBeenReviewedToday = false").sorted(byKeyPath: "learningTimes")
		AllWordsToReview = results.compactMap({ (word) -> Word? in
			return word
		})
	}
    func RememberWord(_ word: Word) -> Void {
        let index = FindIndexByWordItem(word)
        AllWordsToReview.remove(at: index)
        try! realm.write {
            word.hasBeenReviewedToday = true
            word.rememberTimes += 1
        }
        
    }
    
    func CannotRememberWord(_ word: Word) -> Void {
        let index = FindIndexByWordItem(word)
        AllWordsToReview.remove(at: index)
        try! realm.write {
            word.hasBeenReviewedToday = true
            word.cannotRememberTimes += 1
        }
    }

    func HaveLearnedWord(_ word: Word) -> Void {
        let index = FindIndexByWordItem(word)
        AllWordsToReview.remove(at: index)
        try! realm.write {
            word.hasDoneLearning = true
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
