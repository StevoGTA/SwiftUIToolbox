//
//  ToggleableView.swift
//  SwiftUI Toolbox
//
//  Created by Stevo Brock on 3/15/25.
//  Copyright © 2025 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: ToggleableView
struct ToggleableView : View {

	// MARK: ToggleControl
	enum ToggleControl {
		// Values
		case leadingToggle
		case trailingToggle

		case leadingCheckmark
		case trailingCheckmark

		case leadingCheckmarkCircle
		case trailingCheckmarkCircle

		// Properties
		static	let	`default` = ToggleControl.trailingToggle
	}

	// MARK: Procs
	typealias UpdateProc = (_ toggleable :Toggleable, _ isActive :Bool) -> Void

	// MARK: Properties
			var	body :some View {
								HStack {
									// Leading controls
									if self.toggleControl == .leadingToggle {
										// Toggle
										Toggle("", isOn: self.$isActive)
											.fixedSize()
											.onChange(of: self.isActive) { self.updateProc(self.toggleable, $1) }
										Spacer()
									} else if self.toggleControl == .leadingCheckmark {
										// Checkmark
										self.imageView
										Spacer()
									} else if self.toggleControl == .leadingCheckmarkCircle {
										// Checkmark Circle
										self.imageView
										Spacer()
									}

									// Text
									Text("\(String(self.toggleable.title))")

									// Trailing controls
									if self.toggleControl == .trailingToggle {
										// Toggle
										Spacer()
										Toggle("", isOn: self.$isActive)
											.onChange(of: self.isActive) { self.updateProc(self.toggleable, $1) }
									} else if self.toggleControl == .trailingCheckmark {
										// Checkmark
										Spacer()
										self.imageView
									} else if self.toggleControl == .trailingCheckmarkCircle {
										// Checkmark Circle
										Spacer()
										self.imageView
									}
								}
									.contentShape(Rectangle())
									.onTapGesture {
										// Toggle local state
										self.isActive.toggle()

										// Call proc
										self.updateProc(self.toggleable, self.isActive)
									}
							}

	private	let	toggleable :Toggleable
	private	let	toggleControl :ToggleControl

	private	let	updateProc :UpdateProc

	private	var	imageView :some View {
					ZStack {
						// Check toggle control
						if (self.toggleControl == .leadingCheckmark) ||
								(self.toggleControl == .trailingCheckmark) {
							// Check mark
							if self.isActive {
								// Currently active
								Image(systemName: "checkmark")
									.foregroundColor(.accentColor)
							} else {
								// Currently inactive
								Image(systemName: "checkmark")
									.opacity(0.25)
							}
						} else {
							// Checkmark circle
							if self.isActive {
								// Currently active
								Image(systemName: "checkmark.circle")
									.foregroundColor(.accentColor)
							} else {
								// Currently inactive
								Image(systemName: "checkmark.circle")
									.opacity(0.25)
							}
						}
					}
				}

	@State
	private	var	isActive :Bool

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(_ toggleable :Toggleable, toggleControl :ToggleControl = ToggleControl.default,
			updateProc :UpdateProc? = nil) {
		// Store
		self.toggleable = toggleable
		self.toggleControl = toggleControl

		self.updateProc = updateProc ?? { $0.isActive = $1 }

		// Setup
		self.isActive = toggleable.isActive
	}
}

//----------------------------------------------------------------------------------------------------------------------
// MARK: ToggleableView_Previews
struct ToggleableView_Previews : PreviewProvider {

	// MARK: Properties
	static	let	toggleable = Toggleable(title: "Sample", isActive: true)

	static	var previews :some View {
						VStack {
							ToggleableView(self.toggleable, toggleControl: .leadingToggle)
							ToggleableView(self.toggleable, toggleControl: .trailingToggle)
							ToggleableView(self.toggleable, toggleControl: .leadingCheckmark)
							ToggleableView(self.toggleable, toggleControl: .trailingCheckmark)
							ToggleableView(self.toggleable, toggleControl: .leadingCheckmarkCircle)
							ToggleableView(self.toggleable, toggleControl: .trailingCheckmarkCircle)
						}
					}
}
