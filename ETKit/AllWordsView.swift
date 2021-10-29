//
//  AllWordsView.swift
//  ETKit
//
//  Created by Xi on 2021/10/17.
//

import SwiftUI

struct AllWordsView: View {
	
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
    
    var word: Word
    var wordMeaningString: String = ""
    @EnvironmentObject var allWordsAndAddWordModel: AllWordsAndAddWordModel
    
    init(word: Word) {
        self.word = word
        for i in 0..<self.word.meanings.count {
            wordMeaningString += self.word.meanings[i].partOfSpeech + " " + self.word.meanings[i].meaning + "  "
        }
    }
    
    var body: some View {
        HStack {
            Button(action: {allWordsAndAddWordModel.ChangeDoneLearningState(word)}, label: {
                if !word.hasDoneLearning {
                    Image(systemName: "checkmark.square")
                } else {
                    Image(systemName: "checkmark.square.fill")
                }
            })
                .padding(.leading, 10)
                .foregroundColor(.black)
            Text(word.word)
                .bold()
                .padding(.vertical)
                .padding(.leading, 5)
            Spacer()
            Text(wordMeaningString).padding()
        }
    }
    
}

struct AllWordsView_Previews: PreviewProvider {
    static var previews: some View {
        AllWordsView()
    }
}
