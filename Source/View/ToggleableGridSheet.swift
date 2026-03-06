//
//  ToggleableGridSheet.swift
//  SwiftUI Toolbox
//
//  Created by Stevo Brock on 3/5/25.
//  Copyright © 2026 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: ToggleableGridSheet
struct ToggleableGridSheet : View {

	// MARK: Procs
	typealias CancelProc = () -> Void
	typealias ConfirmProc = () -> Void

	// MARK: Properties
			var	body :some View {
						NavigationView {
							ToggleableGrid(self.toggleableWrappers, updatedProc: { self.updateUI() })
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
	private	let	toggleableWrappers :[ToggleableWrapper]

	private	let	confirmButtonTitle :String
	private	let	confirmProc :ConfirmProc

	private	let	cancelButtonTitle :String
	private	let	cancelProc :CancelProc?

	@State
	private	var	confirmButtonEnabled = true

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(_ title :String, toggleables :[Toggleable], confirmButtonTitle :String = "Confirm",
			confirmProc :@escaping ConfirmProc, cancelButtonTitle :String = "Cancel",
			cancelProc :CancelProc? = nil) {
		// Store
		self.title = title
		self.toggleableWrappers = toggleables.map({ ToggleableWrapper($0) })

		self.confirmButtonTitle = confirmButtonTitle
		self.confirmProc = confirmProc

		self.cancelButtonTitle = cancelButtonTitle
		self.cancelProc = cancelProc
	}

	// MARK: Private methods
	//------------------------------------------------------------------------------------------------------------------
	private func confirm() {
		// Update toggleables
		self.toggleableWrappers.forEach({ $0.commit() })

		// Call proc
		self.confirmProc()
	}

	// MARK: Private methods
	//------------------------------------------------------------------------------------------------------------------
	private func updateUI() {
		// Update
		self.confirmButtonEnabled = self.toggleableWrappers.first(where: { $0.isActive }) != nil
	}
}

//----------------------------------------------------------------------------------------------------------------------
// MARK: ToggleableGridSheet_Previews
struct ToggleableGridSheet_Previews : PreviewProvider {

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
							ToggleableGridSheet("Title", toggleables: self.toggleables, confirmProc: {})
						}
					}
}
