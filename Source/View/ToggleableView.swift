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

	// MARK: TogglePlacement
	enum TogglePlacement {
		// Values
		case leadingToggle
		case trailingToggle

		case leadingCheckmark
		case trailingCheckmark

		case leadingCheckmarkCircle
		case trailingCheckmarkCircle

		// Properties
		static	let	`default` = TogglePlacement.trailingToggle
	}

	// MARK: Procs
	typealias UpdateProc = () -> Void

	// MARK: Properties
			var	body :some View {
						HStack {
							// Leading placements
							if self.togglePlacement == .leadingToggle {
								// Toggle
								Toggle("", isOn: self.$toggleable.isActive)
									.fixedSize()
									.onChange(of: self.toggleable.isActive) { self.noteUpdated() }
								Spacer()
							} else if self.togglePlacement == .leadingCheckmark {
								// Checkmark
								self.imageView
								Spacer()
							} else if self.togglePlacement == .leadingCheckmarkCircle {
								// Checkmark Circle
								self.imageView
								Spacer()
							}

							// Text
							Text("\(String(self.toggleable.title))")

							// Trailing placements
							if self.togglePlacement == .trailingToggle {
								// Toggle
								Spacer()
								Toggle("", isOn: self.$toggleable.isActive)
									.fixedSize()
									.onChange(of: self.toggleable.isActive) { self.noteUpdated() }
							} else if self.togglePlacement == .trailingCheckmark {
								// Checkmark
								Spacer()
								self.imageView
							} else if self.togglePlacement == .trailingCheckmarkCircle {
								// Checkmark Circle
								Spacer()
								self.imageView
							}
						}
							.contentShape(Rectangle())
							.onTapGesture {
								// Toggle local state
								self.toggleable.isActive.toggle()

								// Call proc
								self.noteUpdated()
							}
					}

	@ObservedObject
	private	var	toggleable :Toggleable

	private	let	togglePlacement :TogglePlacement

	private	let	updateProc :UpdateProc

	private	var	imageView :some View {
						ZStack {
							// Check toggle control
							if (self.togglePlacement == .leadingCheckmark) ||
									(self.togglePlacement == .trailingCheckmark) {
								// Check mark
								Image(systemName: "checkmark")
									.foregroundStyle(self.toggleable.isActive ? Color.accentColor : .primary)
									.opacity(self.toggleable.isActive ? 1.0 : 0.1)
									.scaleEffect(self.toggleable.isActive ? 1 : 0.9)
									.animation(.smooth(duration: 0.2), value: self.toggleable.isActive)
							} else {
								// Checkmark circle
								Image(systemName: self.toggleable.isActive ? "checkmark.circle.fill" : "circle")
									.foregroundStyle(self.toggleable.isActive ? Color.accentColor : .primary)
									.opacity(self.toggleable.isActive ? 1.0 : 0.1)
									.scaleEffect(self.toggleable.isActive ? 1 : 0.9)
									.animation(.smooth(duration: 0.2), value: self.toggleable.isActive)
							}
						}
					}

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(_ toggleable :Toggleable, togglePlacement :TogglePlacement = TogglePlacement.default,
			updateProc :UpdateProc? = nil) {
		// Store
		self.toggleable = toggleable
		self.togglePlacement = togglePlacement

		self.updateProc = updateProc ?? {}
	}

	// MARK: Private methods
	//------------------------------------------------------------------------------------------------------------------
	private func noteUpdated() {
		// Let's have some feedback!
#if os(iOS)
		UIImpactFeedbackGenerator(style: .light).impactOccurred()
#endif

		// Call proc
		self.updateProc()
	}
}

//----------------------------------------------------------------------------------------------------------------------
// MARK: ToggleableView_Previews
struct ToggleableView_Previews : PreviewProvider {

	// MARK: Properties
	static	let	toggleables :[Toggleable] =
					[
						Toggleable(title: "Sample 1", isActive: false),
						Toggleable(title: "Sample 2", isActive: true),
						Toggleable(title: "Sample 3", isActive: false),
						Toggleable(title: "Sample 4", isActive: true),
						Toggleable(title: "Sample 5", isActive: false),
						Toggleable(title: "Sample 6", isActive: true),
					]

	static	var previews :some View {
						List {
							ToggleableView(self.toggleables[0], togglePlacement: .leadingToggle)
							ToggleableView(self.toggleables[1], togglePlacement: .trailingToggle)
							ToggleableView(self.toggleables[2], togglePlacement: .leadingCheckmark)
							ToggleableView(self.toggleables[3], togglePlacement: .trailingCheckmark)
							ToggleableView(self.toggleables[4], togglePlacement: .leadingCheckmarkCircle)
							ToggleableView(self.toggleables[5], togglePlacement: .trailingCheckmarkCircle)
						}
							.padding()
					}
}
