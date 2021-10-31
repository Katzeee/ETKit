//
//  DeliverWordsToWatch.swift
//  ETKit
//
//  Created by x on 2021/10/30.
//

import Foundation


class DeliverWordsToWatch {
   
    let allWordsAndAddWordModel = AllWordsAndAddWordModel()
    let messageSessionOnPhone = MessageSessionOnPhone()

    var allWordsForWatch: [WordForWatch] = []
    var allWordsForWatchJSON: [Data] = []
    var allWordItemsWord: [String] = []

    
    func DeliverAllWords() -> Void {
        allWordsForWatch = []
        
        for i in 0..<allWordsAndAddWordModel.AllWords.count {
            
            allWordItemsWord.append(allWordsAndAddWordModel.AllWords[i].word)
            
            allWordsForWatch.append(
                WordForWatch(id: allWordsAndAddWordModel.AllWords[i].id,
                             word: allWordsAndAddWordModel.AllWords[i].word,
                            meanings: "还没有写"))
            
            do {
                try allWordsForWatchJSON.append(allWordsForWatch[i].encoded())
            } catch {
                print(error)
            }
            
        }
        
        print(allWordsForWatchJSON)


        messageSessionOnPhone.session.transferUserInfo(["message" : allWordsForWatch[1].word, "oneWord" : allWordItemsWord, KeysOfSharedObjects.allWords.rawValue: allWordsForWatchJSON])

    
        
    }
    
    func TestDeliver() -> Void {
        do {
            try messageSessionOnPhone.session.updateApplicationContext(["allWords" : allWordsForWatch])
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
