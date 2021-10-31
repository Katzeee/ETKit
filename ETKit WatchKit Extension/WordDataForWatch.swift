//
//  WordDataForWatch.swift
//  ETKit WatchKit Extension
//
//  Created by x on 2021/10/30.
//

import Foundation

struct WordForWatch: Identifiable {
    
    
    var id: UUID = UUID() //唯一id
    var word: String = "" //单词本身
    let meanings: String = "" //单词意思,一对多的关系

    

}
