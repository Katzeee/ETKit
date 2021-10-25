//
//  AllWordsView.swift
//  ETKit
//
//  Created by Xi on 2021/10/17.
//

import SwiftUI

struct AllWordsView: View {
	
	@StateObject var learnWordModel = AllWordsAndAddWordModel()
	
	
    var body: some View {
		ScrollView {
			VStack() {
				ForEach(learnWordModel.AllWords) { word in
					HStack {
					
						Text(word.word).bold().padding()
						Spacer()
						ForEach(word.meanings) { meaning in
							Text(meaning.partOfSpeech + meaning.meaning).padding()
						}
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					.background(Color.gray.opacity(0.15))
					.cornerRadius(10)
					.padding([.leading, .horizontal])
					.contentShape(RoundedRectangle(cornerRadius: 10))
					.contextMenu(menuItems: {
						Button(action: {learnWordModel.DeleteWord(word)}, label: {
							Text("Delete Word")
						})
						Button(action: {
							learnWordModel.openNewPage.toggle()
							learnWordModel.updateWordItem = word
						}, label: {
							Text("Update Word")
						})
					})
				}
			}
			
		}
		.navigationTitle("All Words")
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action: {learnWordModel.openNewPage.toggle()}) {
					Image(systemName: "plus").font(.title2)
				}
			}
		}
		.sheet(isPresented: $learnWordModel.openNewPage) {
			AddWordView().environmentObject(learnWordModel)
		}
    }
}

struct AllWordsView_Previews: PreviewProvider {
    static var previews: some View {
        AllWordsView()
    }
}
