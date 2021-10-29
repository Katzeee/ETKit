//
//  AddWordModel.swift
//  ETKit
//
//  Created by Xi on 2021/10/16.
//

import Foundation
import RealmSwift
import SwiftUI

class AllWordsAndAddWordModel: ObservableObject {
	
	let realm = try! Realm()
	@Published var AllWords: [Word] = [] //所有单词
	@Published var openNewPage: Bool = false //用于弹出新界面
	
	//static var numbersOfMeaning: Int = 1 //所有单词的所有意思，用做id
	@Published var AllMeanings: [OneMeaningOfWord] = [OneMeaningOfWord(id: Date())] //一个单词的所有意思,初始有一个意思
	@Published var word: String = ""
	@Published var meanings: [String] = [""]
	@Published var partOfSpeechs: [String] = [WordConstantAttribute.PartOfSpeech.English.Noun.rawValue]
    @Published var language: String = WordConstantAttribute.Languages.English.rawValue
	@Published var updateWordItem: Word?
    @Published var addWordAlert: Bool = false
	
	
	func AddOneMeaning() -> Void {
		//LearnWordModel.numbersOfMeaning += 1
		meanings.append("")
		partOfSpeechs.append(WordConstantAttribute.PartOfSpeech.English.Noun.rawValue)
		AllMeanings.append(OneMeaningOfWord(id: Date()))
	}
	
	func DeleteOneMeaning() -> Void {
		if AllMeanings.count > 1 {
			meanings = meanings.dropLast()
			partOfSpeechs = partOfSpeechs.dropLast()
			AllMeanings = AllMeanings.dropLast()
		}
	}
	
	//通过内容找到索引
	func FindIndexByMeaningContent(_ meaningContent: OneMeaningOfWord) -> Int {
		for i in 0..<AllMeanings.count {
			if AllMeanings[i] == meaningContent {
				return i
			}
		}
		return -1 //Search Fail
	}
	
	//提交单词到数据库
	func CommitWord(presentation: Binding<PresentationMode>) -> Void {
		
		
		
//		总词数加一
//		let userDefault = UserDefaults.standard
//		let numbersOfAllWords = userDefault.integer(forKey: UserInfo().numbersOfAllWords)
//		userDefault.set(numbersOfAllWords + 1, forKey: UserInfo().numbersOfAllWords)
		
		if let avialiableWordItem = updateWordItem { //判断这次是否是更新
			//这次是更新
			try! realm.write {
                
				avialiableWordItem.word = word
                avialiableWordItem.language = language
				
				avialiableWordItem.meanings.removeAll()
				for i in 0..<AllMeanings.count {
					AllMeanings[i].wordMeaning.meaning = meanings[i]
					AllMeanings[i].wordMeaning.partOfSpeech = partOfSpeechs[i]
					print(AllMeanings[i].wordMeaning)
					avialiableWordItem.meanings.append(AllMeanings[i].wordMeaning)
				
				}
				
			}
			
		} else {
			
			//这次是加词
			//构造新Word
			let wordItem: Word = Word()
			wordItem.word = word
//			wordItem.id = AllWords.count + 1
            wordItem.language = language
			wordItem.addTime = Date() //创建词的时候需要加入这个，在下面改这个词的时候不需要管这个参数
			for i in 0..<AllMeanings.count {
				AllMeanings[i].wordMeaning.meaning = meanings[i]
				AllMeanings[i].wordMeaning.partOfSpeech = partOfSpeechs[i]
				print(AllMeanings[i].wordMeaning)
				wordItem.meanings.append(AllMeanings[i].wordMeaning)
			}
			print(wordItem)
			try! realm.write {
				realm.add(wordItem)
			}

		}

		
		FetchWords()//添加完词之后更新界面
		
		
		presentation.wrappedValue.dismiss()
	}
    
    
	
	//更新词之前做准备，初始化数据
	func InitForUpdatingWord() -> Void {
		guard let updateWordItem = updateWordItem else {return} //解开问号,if not nil
		word = updateWordItem.word
		AllMeanings = []
		meanings = []
		partOfSpeechs = []
		for i in 0..<updateWordItem.meanings.count {
			meanings.append(updateWordItem.meanings[i].meaning)
			partOfSpeechs.append(updateWordItem.meanings[i].partOfSpeech)
			AllMeanings.append(OneMeaningOfWord(wordMeaning: updateWordItem.meanings[i], id: Date()))
		}
	}
	
	func InitForNewComingWord() -> Void {
		AllMeanings = [OneMeaningOfWord(id: Date())]
		word = ""
		meanings = [""]
		partOfSpeechs = [WordConstantAttribute.PartOfSpeech.English.Noun.rawValue]
		updateWordItem = nil
	}
	
    //从数据库中查询所有词以更新
	func FetchWords() -> Void {
		
		let results = realm.objects(Word.self)
		AllWords = results.compactMap({ (word) -> Word? in
			return word
		})
	}
	
	func DeleteWord(_ wordItem: Word) -> Void {
		try! realm.write {
			realm.delete(wordItem)
			FetchWords()//删除完词之后更新
		}
	}
    
    func ChangeDoneLearningState(_ word: Word) -> Void {
        try! realm.write {
            word.hasDoneLearning.toggle()
            FetchWords()
        }
    }
	
	init() {
		FetchWords()
//		meaningsWithPartOfSpeechs.append(WordMeaning())
		InitForNewComingWord()
	}
	
	
	//单词的意思
	struct OneMeaningOfWord: Identifiable, Equatable {
		var wordMeaning: WordMeaning = WordMeaning()
		var id: Date
	}
}
