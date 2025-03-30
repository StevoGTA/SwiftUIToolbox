//
//  ToggleableList.swift
//  SwiftUI Toolbox
//
//  Created by Stevo Brock on 3/15/25.
//  Copyright © 2025 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: ToggleableList
struct ToggleableList : View {

	// MARK: Properties
			var	body :some View {
								List(self.toggleables) {
									ToggleableView($0, toggleControl: self.toggleControl,
											updateProc: self.updateProc)
								}
							}

	private	let	toggleables :[Toggleable]
	private	let	toggleControl :ToggleableView.ToggleControl

	private	let	updateProc :ToggleableView.UpdateProc?

	//------------------------------------------------------------------------------------------------------------------
	init(_ toggleables :[Toggleable],
			toggleControl :ToggleableView.ToggleControl = ToggleableView.ToggleControl.default,
			updateProc :ToggleableView.UpdateProc? = nil) {
		// Store
		self.toggleables = toggleables
		self.toggleControl = toggleControl

		self.updateProc = updateProc
	}
}

//----------------------------------------------------------------------------------------------------------------------
// MARK: ToggleableList_Previews
struct ToggleableList_Previews : PreviewProvider {

	// MARK: Properties
	static	let	toggleables =
					[
						Toggleable(title: "One", isActive: true),
						Toggleable(title: "Two", isActive: false),
						Toggleable(title: "Three", isActive: true),
						Toggleable(title: "Four", isActive: false),
						Toggleable(title: "Five", isActive: true),
						Toggleable(title: "Six", isActive: false),
					]

	static	var previews :some View {
						VStack {
							ToggleableList(self.toggleables, toggleControl: .trailingCheckmarkCircle)
						}
					}
}
