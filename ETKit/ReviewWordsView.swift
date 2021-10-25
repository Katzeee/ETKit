//
//  ReviewWordsView.swift
//  ETKit
//
//  Created by Xi on 2021/10/21.
//

import SwiftUI

struct ReviewWordsView: View {
	@StateObject var reviewWordsModel = ReviewWordsModel()
	
    var body: some View {
		ScrollView {
			LazyVGrid(columns: [GridItem()]) {
			//VStack {
				ForEach(reviewWordsModel.AllWordsToReview) { eachWord in
					WordCardView(word: eachWord)
				}
				

			}
		}
		
		
    }
}




struct WordCardView: View {
	
	@State var isFolded: Bool = true
	let word: Word
	var body: some View {
		ZStack(alignment: .leading) {
			VStack {
				Text(word.word).padding()
				if !isFolded {
					ForEach(word.meanings) { meaning in
						Text(meaning.partOfSpeech + meaning.meaning).padding()
					}
				}
			}
			Rectangle().foregroundColor(.blue).opacity(0.3).cornerRadius(12).padding(.horizontal).onTapGesture { isFolded.toggle() }
		}
		
	}
}



struct ReviewWordsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewWordsView()
    }
}
