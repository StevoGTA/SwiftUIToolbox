//
//  ToggleableGrid.swift
//  SwiftUI Toolbox
//
//  Created by Stevo Brock on 3/5/25.
//  Copyright © 2026 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: ToggleableGrid
struct ToggleableGrid : View {

	// MARK: Properties
			var	body :some View {
						VStack {
							Text("\(self.activeToggleableWrappersCount) of \(self.toggleableWrappers.count) selected")
								.font(.subheadline)
								.foregroundStyle(.secondary)

							// Action buttons
							HStack(spacing: 12.0) {
								Button("None") { withAnimation(.smooth) { self.selectNone() } }
									.buttonStyle(.bordered)
									.disabled(!self.noneButtonEnabled)

								Button("All") { withAnimation(.smooth) { self.selectAll() } }
									.buttonStyle(.bordered)
									.disabled(!self.allButtonEnabled)
							}

							ScrollView {
								LazyVGrid(columns: [GridItem(.adaptive(minimum: 60.0))], spacing: 14.0) {
									ForEach(self.toggleableWrappers, id: \.id) {
										ToggleableCard($0, updateProc: { self.updateUI() })
									}
								}
									.padding()
							}
						}
					}

	private	let	toggleableWrappers :[ToggleableWrapper]

	@State
	private	var	activeToggleableWrappersCount = 0

	@State
	private	var	noneButtonEnabled = true

	@State
	private	var	allButtonEnabled = true

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(_ toggleableWrappers :[ToggleableWrapper]) {
		// Store
		self.toggleableWrappers = toggleableWrappers

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
		// Update UI
		self.activeToggleableWrappersCount = self.toggleableWrappers.filter({ $0.isActive }).count
		self.noneButtonEnabled = self.toggleableWrappers.first(where: { $0.isActive }) != nil
		self.allButtonEnabled = self.toggleableWrappers.first(where: { !$0.isActive }) != nil
	}
}

//----------------------------------------------------------------------------------------------------------------------
// MARK: ToggleableGrid_Previews
struct ToggleableGrid_Previews : PreviewProvider {

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
							ToggleableGrid(self.toggleables)
						}
					}
}
