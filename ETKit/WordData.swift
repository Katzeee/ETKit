//
//  WordData.swift
//  ETKit
//
//  Created by Xi on 2021/10/15.
//

import Foundation
import RealmSwift

struct WordConstantAttribute {
	
	//语种
	enum Languages: String, CaseIterable, Identifiable {
		case English = "English"
		case German = "German"
		case Japanese = "Japanese"
		case Others = "Others"
		
		var id: String { self.rawValue }
	}
	
	//词性
	struct PartOfSpeech {
		enum English: String, CaseIterable, Identifiable {
			case Noun = "n."
			case Verb = "v."
			case Pronoun = "pron."
			case Adjective = "adj."
			case Adverb = "adv."
			case Numeral = "num." //数词
			case Article = "art." //冠词
			case Prepositon = "prep."
			case Conjunction = "conj."
			case Interjection = "int." //叹词
			case Others = "oth."
			
			var id: String { self.rawValue }
		}
	}
	
	
}

class WordMeaning: Object, Identifiable {
	var id: Date = Date()
	@objc dynamic var partOfSpeech: String = "Noun"//词性
//	var partOfSpeechType: WordConstantAttribute.PartOfSpeech.English? {
//		get {
//			return WordConstantAttribute.PartOfSpeech.English(rawValue: partOfSpeech)
//		}
//		set {
//			partOfSpeech = newValue?.rawValue ?? ""
//		}
//	}
	@objc dynamic var meaning: String = ""
}


//单词信息
class Word: Object, Identifiable {
	@objc dynamic var id: UUID = UUID() //唯一id
	@objc dynamic var word: String = "" //单词本身
	let meanings = RealmSwift.List<WordMeaning>() //单词意思,一对多的关系
	@objc dynamic var language: String = "" //单词语种
//	var languageType: WordConstantAttribute.Languages? {
//		get {
//			return WordConstantAttribute.Languages(rawValue: language)
//		}
//		set {
//			language = newValue?.rawValue ?? ""
//		}
//	}
	
	@objc dynamic var hasDoneLearning: Bool = false //是否掌握
	@objc dynamic var learningTimes: Int = 0 //学习次数
    @objc dynamic var rememberTimes: Int = 0 //认识次数
    @objc dynamic var cannotRememberTimes: Int = 0 //不认识次数
	@objc dynamic var addTime: Date = Date() //添加时间
    @objc dynamic var hasBeenReviewedToday: Bool = false//今天是否已复习
    //@objc dynamic var hasBeenReviewedToday: Bool = false//今天是否已复习
	
	override static func primaryKey() -> String? {
		return "id"
	}
}
