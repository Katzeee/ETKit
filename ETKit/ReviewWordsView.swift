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
        ZStack {
            Color(.gray)
                .opacity(0.15)
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem()]) {
                //VStack {
                    ForEach(reviewWordsModel.AllWordsToReview) { eachWord in
                        WordCardView(word: eachWord)
                            .environmentObject(reviewWordsModel)
                            
                    }
                    

                }
            }
            .navigationTitle("Words Review")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "gearshape")
                    }
                }
            }
        }
        
		
		
    }
}




struct WordCardView: View {
	
	@State var isFolded: Bool = true
    @State var cardMoveDirection: String = ""
    @State var cardMoveOffset: CGFloat = 0
    @EnvironmentObject var reviewWordsModel: ReviewWordsModel
	let word: Word
	var body: some View {
        ZStack {
            Color(.brown)
            Color(.red)
                .offset(x: 280)
            Color(.green)
                .offset(x: cardMoveOffset < 0 ? cardMoveOffset / 2 : cardMoveOffset)
            HStack(alignment: .center) {
                Button(action: {reviewWordsModel.HaveLearnedWord(word)}, label: {
                    Image(systemName: "cross")
                        .foregroundColor(.white)
                        .padding(.horizontal, 25)
                })
                Spacer()
                Button(action: {reviewWordsModel.RememberWord(word)}, label: {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .padding(.horizontal, 25)
                })
                Button(action: {reviewWordsModel.CannotRememberWord(word)}, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding(.horizontal, 25)
                })
            }//以上是滑动按钮部分
            
            HStack(alignment: .center) {
                Text(word.word).bold().padding()
                Spacer()
                if !isFolded {
                    ForEach(word.meanings) { meaning in
                        Text(meaning.partOfSpeech + meaning.meaning).padding(.trailing)
                    }
                    //padding()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .onTapGesture {
                if cardMoveOffset == 0 {
                    isFolded.toggle()
                }
            }
            //以下是滑动操作控制
            .offset(x: cardMoveOffset)
            .gesture(
                DragGesture()
                    .onChanged({ offset in
                        isFolded = true
                        withAnimation(.default) {
                            if cardMoveDirection == "left" && offset.translation.width > 0 {
                                cardMoveOffset = -140 + offset.translation.width
                            } else if cardMoveDirection == "right" && offset.translation.width < 0 {
                                cardMoveOffset = 70 + offset.translation.width
                            } else {
                                 cardMoveOffset = offset.translation.width
                            }
                        }
                    })
                    .onEnded({ offset in
                        withAnimation(.default) {
                            if cardMoveDirection.isEmpty && offset.translation.width < -40 {
                                cardMoveDirection = "left"
                                cardMoveOffset = -140
                            } else if cardMoveDirection.isEmpty && offset.translation.width > 40 {
                                cardMoveDirection = "right"
                                cardMoveOffset = 70
                            } else {
                                cardMoveOffset = 0
                                cardMoveDirection = ""
                            }
                        }
                    })
            )
        }
        
        .frame(maxWidth: .infinity, alignment: .leading)

        .cornerRadius(10)
        .padding([.leading, .horizontal])
        .contentShape(RoundedRectangle(cornerRadius: 10))
        
		
	}
}



struct ReviewWordsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewWordsView()
    }
}
