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
								List(self.toggleableWrappers) {
									ToggleableView($0, togglePlacement: self.togglePlacement,
											updateProc: { self.updateUI() })
								}
									.contentMargins(.top, 0)
									.safeAreaInset(edge: .top) {
										HStack {
											Spacer()

											Button("None") { selectNone() }
												.disabled(!self.noneButtonEnabled)
												.padding()

											Button("All") { selectAll() }
												.disabled(!self.allButtonEnabled)
												.padding()

											Spacer()
										}
									}
							}

	private	let	toggleableWrappers :[ToggleableWrapper]
	private	let	togglePlacement :ToggleableView.TogglePlacement

	@State
	private	var	noneButtonEnabled = true

	@State
	private	var	allButtonEnabled = true

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(_ toggleableWrappers :[ToggleableWrapper],
			togglePlacement :ToggleableView.TogglePlacement = ToggleableView.TogglePlacement.default) {
		// Store
		self.toggleableWrappers = toggleableWrappers
		self.togglePlacement = togglePlacement

		// Update UI
		self._noneButtonEnabled = State(initialValue: self.toggleableWrappers.first(where: { $0.isActive }) != nil)
		self._allButtonEnabled = State(initialValue: self.toggleableWrappers.first(where: { !$0.isActive }) != nil)
	}

	// MARK: Private methods
	//------------------------------------------------------------------------------------------------------------------
	private func selectAll() {
		// Update
		self.toggleableWrappers.forEach() { $0.isActive = true }

		// Update UI
		updateUI()
	}

	//------------------------------------------------------------------------------------------------------------------
	private func selectNone() {
		// Update
		self.toggleableWrappers.forEach() { $0.isActive = false }

		// Update UI
		updateUI()
	}

	//------------------------------------------------------------------------------------------------------------------
	private func updateUI() {
		// Update UI
		self.noneButtonEnabled = self.toggleableWrappers.first(where: { $0.isActive }) != nil
		self.allButtonEnabled = self.toggleableWrappers.first(where: { !$0.isActive }) != nil
	}
}

//----------------------------------------------------------------------------------------------------------------------
// MARK: ToggleableList_Previews
struct ToggleableList_Previews : PreviewProvider {

	// MARK: Properties
	static	let	toggleables =
					[
						ToggleableWrapper(Toggleable(title: "One", isActive: true)),
						ToggleableWrapper(Toggleable(title: "Two", isActive: false)),
						ToggleableWrapper(Toggleable(title: "Three", isActive: true)),
						ToggleableWrapper(Toggleable(title: "Four", isActive: false)),
						ToggleableWrapper(Toggleable(title: "Five", isActive: true)),
						ToggleableWrapper(Toggleable(title: "Six", isActive: false)),
					]

	static	var previews :some View {
						VStack {
							ToggleableList(self.toggleables, togglePlacement: .trailingCheckmarkCircle)
						}
					}
}
