//
//  DeliverWordsToWatch.swift
//  ETKit
//
//  Created by x on 2021/10/30.
//

import Foundation


class DeliverWordsToWatch {
   
    let allWordsAndAddWordModel = AllWordsAndAddWordModel()
    let model = MessageSessionOnPhone()
    var allWordsForWatch: [WordForWatch] = []
    var allWordItemsWord: [String] = []

    
    func DeliverAllWords() -> Void {
        allWordsForWatch = []
        //print(allWordsAndAddWordModel.AllWords)
        for i in 0..<allWordsAndAddWordModel.AllWords.count {
            allWordItemsWord.append(allWordsAndAddWordModel.AllWords[i].word)
            allWordsForWatch.append(
                WordForWatch(id: allWordsAndAddWordModel.AllWords[i].id
                             , word: allWordsAndAddWordModel.AllWords[i].word))
        }
        print(allWordsForWatch)
        
        model.session.transferUserInfo(["message" : allWordsForWatch[1].word, "oneWord" : allWordItemsWord])
        //model.session.transferUserInfo(["allWords" : allWordsForWatch])
        //try! model.session.updateApplicationContext(["allWords" : allWordsForWatch])
        
    }
    
    func TestDeliver() -> Void {
        model.session.transferUserInfo(["allWords" : [WordForWatch(word: "test1"), WordForWatch(word: "test2")]])
        do {
            try model.session.updateApplicationContext(["allWords" : allWordsForWatch])
        } catch {
            print(error)
        }
    }
    
    
    init() {
       // DeliverAllWords()
    }
    
    func DeliverReviewWords() -> Void {
        
    }
}
