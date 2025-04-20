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
								NavigationView {
									ToggleableList(self.toggleables, toggleControl: self.toggleControl,
												   updateProc: { self.update(toggleable: $0, to: $1) })
										.navigationBarTitle(self.title, displayMode: .inline)
											.font(.system(size: 16, weight: .medium, design: .rounded))
										.if({ self.cancelProc != nil }()) { view in
											view
												.navigationBarItems(
														leading: Button(self.cancelButtonTitle) { self.cancelProc!() },
														trailing: Button(self.confirmButtonTitle) { self.confirm() })
										}
										.if({ self.cancelProc == nil }()) { view in
											view
												.navigationBarItems(
														trailing: Button(self.confirmButtonTitle) { self.confirm() })
										}
								}
							}

	private	let	title :String
	private	let	toggleables :[Toggleable]
	private	let	toggleControl :ToggleableView.ToggleControl

	private	let	confirmButtonTitle :String
	private	let	confirmProc :ConfirmProc

	private	let	cancelButtonTitle :String
	private	let	cancelProc :CancelProc?

	@State
	private	var	isActives :[Bool]

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(_ title :String, toggleables :[Toggleable],
			toggleControl :ToggleableView.ToggleControl = ToggleableView.ToggleControl.default,
			confirmButtonTitle :String = "Confirm", confirmProc :@escaping ConfirmProc,
			cancelButtonTitle :String = "Cancel", cancelProc :CancelProc? = nil) {
		// Store
		self.title = title
		self.toggleables = toggleables
		self.toggleControl = toggleControl

		self.confirmButtonTitle = confirmButtonTitle
		self.confirmProc = confirmProc

		self.cancelButtonTitle = cancelButtonTitle
		self.cancelProc = cancelProc

		self.isActives = toggleables.map({ $0.isActive })
	}

	// MARK: Private methods
	//------------------------------------------------------------------------------------------------------------------
	private func update(toggleable :Toggleable, to isActive :Bool) {
		// Update
		self.isActives[self.toggleables.firstIndex(where: { $0 === toggleable })!] = isActive
	}

	//------------------------------------------------------------------------------------------------------------------
	private func confirm() {
		// Update toggleables
		self.toggleables.enumerated().forEach() { $0.element.isActive = self.isActives[$0.offset] }

		// Call proc
		self.confirmProc()
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
									toggleControl: .trailingCheckmarkCircle, confirmProc: {})
						}
					}
}
