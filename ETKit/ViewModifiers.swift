//
//  ViewModifiers.swift
//  ETKit
//
//  Created by Xi on 2021/10/15.
//

import SwiftUI

//Add a left label
struct AddLeftLabel: ViewModifier {
	var Label: String
	func body(content: Content) -> some View {
		HStack {
			Text(Label).bold().padding()
			Divider()
			content
		}
	}
}

struct AddSpacer: ViewModifier {
	var LeftOrRight: String
	func body(content: Content) -> some View {
		HStack {
			if LeftOrRight == "Left" {
				Spacer()
				content
			} else {
				content
				Spacer()
			}
		}
	}
}

extension View {
	func addLeftLabel(_ label:String) -> some View {
		modifier(AddLeftLabel(Label:label))
	}
	
	func addSpacer(_ leftOrRight: String) -> some View {
		modifier(AddSpacer(LeftOrRight: leftOrRight))
	}
}
