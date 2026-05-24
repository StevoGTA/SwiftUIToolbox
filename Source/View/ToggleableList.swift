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
							Text("\(self.activeToggleablesCount) of \(self.toggleables.count) selected")
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
									ForEach(self.toggleables, id: \.id) {
										ToggleableView($0, togglePlacement: self.togglePlacement,
												updateProc: { self.updateUI() })
									}
								}
							}
								.listStyle(.insetGrouped)
						}
					}

	private	let	toggleables :[Toggleable]
	private	let	togglePlacement :ToggleableView.TogglePlacement

	private	let	updatedProc :() -> Void

	@State
	private	var	activeToggleablesCount = 0

	@State
	private	var	noneButtonEnabled = true

	@State
	private	var	allButtonEnabled = true

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(_ toggleables :[Toggleable],
			togglePlacement :ToggleableView.TogglePlacement = ToggleableView.TogglePlacement.default,
			updatedProc :@escaping () -> Void = {}) {
		// Store
		self.toggleables = toggleables
		self.togglePlacement = togglePlacement

		self.updatedProc = updatedProc

		// Update UI
		self._activeToggleablesCount = State(initialValue: self.toggleables.filter({ $0.isActive }).count)
		self._noneButtonEnabled = State(initialValue: self.toggleables.first(where: { $0.isActive }) != nil)
		self._allButtonEnabled = State(initialValue: self.toggleables.first(where: { !$0.isActive }) != nil)
	}

	// MARK: Private methods
	//------------------------------------------------------------------------------------------------------------------
	private func selectAll() {
		// Update
		self.toggleables.forEach() { $0.isActive = true }

		// Update UI
		updateUI()
	}

	//------------------------------------------------------------------------------------------------------------------
	private func selectNone() {
		// Update
		self.toggleables.forEach() { $0.isActive = false }

		// Update UI
		updateUI()
	}

	//------------------------------------------------------------------------------------------------------------------
	private func updateUI() {
		// Call proc
		self.updatedProc()

		// Update UI
		self.activeToggleablesCount = self.toggleables.filter({ $0.isActive }).count
		self.noneButtonEnabled = self.toggleables.first(where: { $0.isActive }) != nil
		self.allButtonEnabled = self.toggleables.first(where: { !$0.isActive }) != nil
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
							ToggleableList(self.toggleables, togglePlacement: .trailingCheckmarkCircle)
						}
					}
}
