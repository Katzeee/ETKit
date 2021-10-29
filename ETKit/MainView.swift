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
	
	
	
    var body: some View {
		NavigationView {
            List {
                ForEach(mainViewNavigationModel.AllTools) { i in
                    NavigationLink(destination: i.view) {
                        VStack(alignment: .leading) {
                            Text(i.name).bold()
                        }
                        //.frame(maxWidth: .infinity, alignment: .leading)
                        //.background(Color.gray.opacity(0.15))
                        //.cornerRadius(10)
                        //.padding()
                    }
                }
            }
			.navigationTitle("Tools")
			.toolbar {
				
			}
			
		}
    }
}












struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
