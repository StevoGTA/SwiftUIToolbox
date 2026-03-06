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
						VStack {
							Text("\(self.activeToggleableWrappersCount) of \(self.toggleableWrappers.count) selected")
								.font(.subheadline)
								.foregroundStyle(.secondary)
							List {
								// Action buttons
								HStack(spacing: 12.0) {
									Button("None") { withAnimation(.smooth) { self.selectNone() } }
										.buttonStyle(.bordered)
										.disabled(!self.noneButtonEnabled)

									Button("All") { withAnimation(.smooth) { self.selectAll() } }
										.buttonStyle(.bordered)
										.disabled(!self.allButtonEnabled)
								}
									.frame(maxWidth: .infinity, alignment: .center)

								// Content
								Section {
									ForEach(self.toggleableWrappers, id: \.id) {
										ToggleableView($0, togglePlacement: self.togglePlacement,
												updateProc: { self.updateUI() })
									}
								}
							}
								.listStyle(.insetGrouped)
						}
					}

	private	let	toggleableWrappers :[ToggleableWrapper]
	private	let	togglePlacement :ToggleableView.TogglePlacement

	private	let	updatedProc :() -> Void

	@State
	private	var	activeToggleableWrappersCount = 0

	@State
	private	var	noneButtonEnabled = true

	@State
	private	var	allButtonEnabled = true

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(_ toggleableWrappers :[ToggleableWrapper],
			togglePlacement :ToggleableView.TogglePlacement = ToggleableView.TogglePlacement.default,
			updatedProc :@escaping () -> Void = {}) {
		// Store
		self.toggleableWrappers = toggleableWrappers
		self.togglePlacement = togglePlacement

		self.updatedProc = updatedProc

		// Update UI
		self._activeToggleableWrappersCount = State(initialValue: self.toggleableWrappers.filter({ $0.isActive }).count)
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
		// Call proc
		self.updatedProc()

		// Update UI
		self.activeToggleableWrappersCount = self.toggleableWrappers.filter({ $0.isActive }).count
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
