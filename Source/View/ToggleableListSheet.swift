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
									ToggleableList(self.toggleableWrappers, togglePlacement: self.togglePlacement)
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
	private	let	toggleableWrappers :[ToggleableWrapper]
	private	let	togglePlacement :ToggleableView.TogglePlacement

	private	let	confirmButtonTitle :String
	private	let	confirmProc :ConfirmProc

	private	let	cancelButtonTitle :String
	private	let	cancelProc :CancelProc?

	@State
	private	var	isActives :[Bool]

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(_ title :String, toggleables :[Toggleable],
			togglePlacement :ToggleableView.TogglePlacement = ToggleableView.TogglePlacement.default,
			confirmButtonTitle :String = "Confirm", confirmProc :@escaping ConfirmProc,
			cancelButtonTitle :String = "Cancel", cancelProc :CancelProc? = nil) {
		// Store
		self.title = title
		self.toggleableWrappers = toggleables.map({ ToggleableWrapper($0) })
		self.togglePlacement = togglePlacement

		self.confirmButtonTitle = confirmButtonTitle
		self.confirmProc = confirmProc

		self.cancelButtonTitle = cancelButtonTitle
		self.cancelProc = cancelProc

		self.isActives = toggleables.map({ $0.isActive })
	}

	// MARK: Private methods
	//------------------------------------------------------------------------------------------------------------------
	private func confirm() {
		// Update toggleables
		self.toggleableWrappers.forEach({ $0.toggleable.isActive = $0.isActive })

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
									togglePlacement: .trailingCheckmarkCircle, confirmProc: {})
						}
					}
}
