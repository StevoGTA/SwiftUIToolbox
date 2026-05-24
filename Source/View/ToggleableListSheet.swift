//
//  ToggleableListSheet.swift
//  SwiftUI Toolbox
//
//  Created by Stevo Brock on 3/15/25.
//  Copyright © 2025 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: ToggleableListSheet
struct ToggleableListSheet : View {

	// MARK: Procs
	typealias CancelProc = () -> Void
	typealias ConfirmProc = () -> Void

	// MARK: Properties
			var	body :some View {
						NavigationStack {
							ToggleableList(self.localToggleables, togglePlacement: self.togglePlacement,
									updatedProc: { self.updateUI() })
								.navigationBarTitle(self.title, displayMode: .inline)
								.if({ self.cancelProc != nil }()) { view in
									view
										.navigationBarItems(
												leading:
														Button(self.cancelButtonTitle) { self.cancelProc!() },
												trailing:
														Button(self.confirmButtonTitle) { self.confirm() }
															.buttonStyle(.borderedProminent)
															.disabled(!self.confirmButtonEnabled))
								}
								.if({ self.cancelProc == nil }()) { view in
									view
										.navigationBarItems(
												trailing:
														Button(self.confirmButtonTitle) { self.confirm() }
															.buttonStyle(.borderedProminent)
															.disabled(!self.confirmButtonEnabled))
								}
						}
					}

	private	let	title :String
	private	let	toggleables :[Toggleable]
	private	let	localToggleables :[Toggleable]
	private	let	togglePlacement :ToggleableView.TogglePlacement

	private	let	confirmButtonTitle :String
	private	let	confirmProc :ConfirmProc

	private	let	cancelButtonTitle :String
	private	let	cancelProc :CancelProc?

	@State
	private	var	confirmButtonEnabled = true

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(_ title :String, toggleables :[Toggleable],
			togglePlacement :ToggleableView.TogglePlacement = ToggleableView.TogglePlacement.default,
			confirmButtonTitle :String = "Confirm", confirmProc :@escaping ConfirmProc,
			cancelButtonTitle :String = "Cancel", cancelProc :CancelProc? = nil) {
		// Store
		self.title = title
		self.toggleables = toggleables
		self.togglePlacement = togglePlacement

		self.confirmButtonTitle = confirmButtonTitle
		self.confirmProc = confirmProc

		self.cancelButtonTitle = cancelButtonTitle
		self.cancelProc = cancelProc

		// Setup
		self.localToggleables = toggleables.map({ Toggleable(title: $0.title, isActive: $0.isActive) })
	}

	// MARK: Private methods
	//------------------------------------------------------------------------------------------------------------------
	private func confirm() {
		// Update toggleables
		for index in 0..<self.toggleables.count {
			// Update
			self.toggleables[index].isActive = self.localToggleables[index].isActive
		}

		// Call proc
		self.confirmProc()
	}

	// MARK: Private methods
	//------------------------------------------------------------------------------------------------------------------
	private func updateUI() {
		// Update
		self.confirmButtonEnabled = self.localToggleables.first(where: { $0.isActive }) != nil
	}
}

//----------------------------------------------------------------------------------------------------------------------
// MARK: ToggleableListSheet_Previews
struct ToggleableListSheet_Previews : PreviewProvider {

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
							ToggleableListSheet("Title", toggleables: self.toggleables,
									togglePlacement: .trailingCheckmarkCircle, confirmProc: {})
						}
					}
}
