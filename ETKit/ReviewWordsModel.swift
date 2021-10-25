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
		let results = realm.objects(Word.self).filter("hasDoneLearning = false").sorted(byKeyPath: "learningTimes")
		AllWordsToReview = results.compactMap({ (word) -> Word? in
			return word
		})
	}
	
	init() {
		GetReviewWords()
	}
}
