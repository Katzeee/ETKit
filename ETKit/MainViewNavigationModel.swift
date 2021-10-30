//
//  MainViewNavigationModel.swift
//  ETKit
//
//  Created by Xi on 2021/10/15.
//

import SwiftUI
import RealmSwift

class MainViewNavigationModel {
	
	private let AllToolName = ["Learning Words", "Diary", "Words Review"] //主界面导航
//	private let AllToolView = [AddWordView.self, DiaryView.self] as [Any]
	private(set) var AllTools: [ViewNavigationData.Tools]

	
	init() {
		AllTools = []
		for i in 0..<AllToolName.count {
			let tool = ViewNavigationData.Tools(id: i, name: AllToolName[i])
			AllTools.append(tool)
		}
        AllTools[0].view = AnyView(AllWordsView())
		AllTools[1].view = AnyView(DiaryView())
		AllTools[2].view = AnyView(ReviewWordsView())
	}
}
