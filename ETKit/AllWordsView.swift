//
//  AllWordsView.swift
//  ETKit
//
//  Created by Xi on 2021/10/17.
//

import SwiftUI

struct AllWordsView: View {
	
    //@EnvironmentObject var allWordsAndAddWordModel: AllWordsAndAddWordModel
	@StateObject var allWordsAndAddWordModel = AllWordsAndAddWordModel()
	
    var body: some View {
		ScrollView {
			VStack() {
				ForEach(allWordsAndAddWordModel.AllWords) { word in
                    AllWordCardView(word: word)
                        .environmentObject(allWordsAndAddWordModel)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(10)
                        .padding([.leading, .horizontal])
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .contextMenu(menuItems: {
                            Button(action: {
                                allWordsAndAddWordModel.openNewPage.toggle()
                                allWordsAndAddWordModel.updateWordItem = word
                            }, label: {
                                Text("Update Word")
                            })
                            Button(action: {allWordsAndAddWordModel.DeleteWord(word)}, label: {
                                Text("Delete Word")
                            })
                            Button(action: {allWordsAndAddWordModel.ChangeDoneLearningState(word)}, label: {
                                HStack {
                                    Text("Done Learning")
                                    if !word.hasDoneLearning {
                                        Image(systemName: "checkmark.square")
                                    } else {
                                        Image(systemName: "checkmark.square.fill")
                                    }
                                }
                            })
                        })
				}
			}
			
		}
		.navigationTitle("All Words")
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action: {allWordsAndAddWordModel.openNewPage.toggle()}) {
					Image(systemName: "plus").font(.title2)
				}
			}
		}
		.sheet(isPresented: $allWordsAndAddWordModel.openNewPage) {
			AddWordView().environmentObject(allWordsAndAddWordModel)
		}
    }
}

struct AllWordCardView: View {
    
    var wordItem: Word
    var word: String
    var wordMeaningString: String = ""
    var hasDoneLearning: Bool
    @EnvironmentObject var allWordsAndAddWordModel: AllWordsAndAddWordModel
    
    init(word: Word?) {
        self.wordItem = word!
        self.word = wordItem.word
        hasDoneLearning = wordItem.hasDoneLearning
        for i in 0..<self.wordItem.meanings.count {
            wordMeaningString += self.wordItem.meanings[i].partOfSpeech + " " + self.wordItem.meanings[i].meaning + "  "
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Button(action: {allWordsAndAddWordModel.ChangeDoneLearningState(wordItem)}, label: {
                   if !hasDoneLearning {
                       Image(systemName: "checkmark.square")
                   } else {
                       Image(systemName: "checkmark.square.fill")
                   }
                })
                    .padding(.leading, 10)
                    .foregroundColor(.black)
                Text(word).bold().padding(.vertical).padding(.leading, 5)
                Spacer()
                Text(wordMeaningString).padding()
            }
           // Text("nextTimeReviewInterval: \(word.nextTimeReviewInterval)")
           // Text("nextTimeReviewIntervalRecord: \(word.nextTimeReviewIntervalRecord)")
           // Text("EFValue: \(word.EFValue)")
        }
        
    }
    
}

struct AllWordsView_Previews: PreviewProvider {
    static var previews: some View {
        AllWordsView()
    }
}
