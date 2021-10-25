//
//  MainView.swift
//  ETKit
//
//  Created by Xi on 2021/10/15.
//

import SwiftUI
import RealmSwift

struct MainView: View {
	
	var mainViewNavigationModel = MainViewNavigationModel() //初始化导航管理
	var dataBaseManager = DataBaseManager() //初始化数据库管理
	
	
	
    var body: some View {
		NavigationView {
			ScrollView {
				ForEach(mainViewNavigationModel.AllTools) { i in
					NavigationLink(destination: i.view) {
						VStack(alignment: .leading) {
							Text(i.name).font(.title)
						}
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding()
						.background(Color.gray.opacity(0.15))
						.cornerRadius(10)
					}
				}
			}
			.navigationTitle("Tools")
			.toolbar {
				
			}
			
			Text(dataBaseManager.realmURL.absoluteString).padding()
		}
    }
}












struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
