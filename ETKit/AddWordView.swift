//
//  AddWordView.swift
//  ETKit
//
//  Created by Xi on 2021/10/15.
//

import SwiftUI

struct AddWordView: View {
	
	@Environment(\.presentationMode) var presentation
	@EnvironmentObject var addWordModel: AllWordsAndAddWordModel
	
	
    var body: some View {
		
		NavigationView {
			List {
				Section("Word") {
					TextField("Text here", text: $addWordModel.word)
				}
                
                Section("Language") {
                    Picker("Language", selection: $addWordModel.language) {
                        ForEach(WordConstantAttribute.Languages.allCases) { language in
                            Text(language.rawValue)
                        }
                    }
                }
                
                
				Section("Meaning") {
					ForEach(addWordModel.AllMeanings) { eachMeaning in
						let index = addWordModel.FindIndexByMeaningContent(eachMeaning)
						HStack {
							
							VStack {
								Picker ("", selection: $addWordModel.partOfSpeechs[index]) {
//								Picker ("", selection: $addWordModel.AllMeanings[index].wordMeaning.partOfSpeechType) {

									ForEach(WordConstantAttribute.PartOfSpeech.English.allCases) { part in
										Text(part.rawValue)
									}
								}
								.pickerStyle(.menu)
							}
							.frame(maxWidth: 40, alignment: .leading)
							
							Divider()
							
							TextField("Meaning",text: $addWordModel.meanings[index])
						}
						
					}
				}
				
			}
			.navigationTitle(addWordModel.updateWordItem != nil ? "Update" : "Add Word")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Button(action: {presentation.wrappedValue.dismiss()}) {
						Text("Cancel")
					}
					
				}
				ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if addWordModel.word == "" { //空单词不允许commit
                            addWordModel.addWordAlert = true
                        }
                        else {
                            addWordModel.CommitWord(presentation: presentation)
                        }
                    }) {
						Text("Done")
                    }.alert(isPresented: $addWordModel.addWordAlert) {
                        Alert(title: Text("word cannot be blank"), message: nil, dismissButton: .default(Text("OK")))
                    }
					
				}
				
			}
			
		}
		

		HStack(spacing: 40.0) {
			Button("Delete", action: {addWordModel.DeleteOneMeaning()}).padding()
			
			Button("Add", action: {addWordModel.AddOneMeaning()}).padding()
		}
		.onAppear(perform: addWordModel.InitForUpdatingWord)
		.onDisappear(perform: addWordModel.InitForNewComingWord)
	}
}



struct AddWordView_Previews: PreviewProvider {
    static var previews: some View {
		AddWordView()
    }
}
