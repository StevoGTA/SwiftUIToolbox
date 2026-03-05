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
								Toggle("", isOn: self.$toggleableWrapper.isActive)
									.fixedSize()
									.onChange(of: self.toggleableWrapper.isActive) { self.noteUpdated() }
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
							Text("\(String(self.toggleableWrapper.title))")

							// Trailing placements
							if self.togglePlacement == .trailingToggle {
								// Toggle
								Spacer()
								Toggle("", isOn: self.$toggleableWrapper.isActive)
									.fixedSize()
									.onChange(of: self.toggleableWrapper.isActive) { self.noteUpdated() }
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
								self.toggleableWrapper.isActive.toggle()

								// Call proc
								self.noteUpdated()
							}
					}

	@ObservedObject
	private	var	toggleableWrapper :ToggleableWrapper

	private	let	togglePlacement :TogglePlacement

	private	let	updateProc :UpdateProc

	private	var	imageView :some View {
						ZStack {
							// Check toggle control
							if (self.togglePlacement == .leadingCheckmark) ||
									(self.togglePlacement == .trailingCheckmark) {
								// Check mark
								Image(systemName: "checkmark")
									.foregroundStyle(self.toggleableWrapper.isActive ? Color.accentColor : .primary)
									.opacity(self.toggleableWrapper.isActive ? 1.0 : 0.1)
									.scaleEffect(self.toggleableWrapper.isActive ? 1 : 0.9)
									.animation(.smooth(duration: 0.2), value: self.toggleableWrapper.isActive)
							} else {
								// Checkmark circle
								Image(systemName: self.toggleableWrapper.isActive ? "checkmark.circle.fill" : "circle")
									.foregroundStyle(self.toggleableWrapper.isActive ? Color.accentColor : .primary)
									.opacity(self.toggleableWrapper.isActive ? 1.0 : 0.1)
									.scaleEffect(self.toggleableWrapper.isActive ? 1 : 0.9)
									.animation(.smooth(duration: 0.2), value: self.toggleableWrapper.isActive)
							}
						}
					}

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(_ toggleableWrapper :ToggleableWrapper, togglePlacement :TogglePlacement = TogglePlacement.default,
			updateProc :UpdateProc? = nil) {
		// Store
		self.toggleableWrapper = toggleableWrapper
		self.togglePlacement = togglePlacement

		self.updateProc = updateProc ?? {}
	}

	// MARK: Private methods
	//------------------------------------------------------------------------------------------------------------------
	private func noteUpdated() {
		// Let's have some feedback!
		UIImpactFeedbackGenerator(style: .light).impactOccurred()

		// Call proc
		self.updateProc()
	}
}

//----------------------------------------------------------------------------------------------------------------------
// MARK: ToggleableView_Previews
struct ToggleableView_Previews : PreviewProvider {

	// MARK: Properties
	static	let	toggleableWrappers :[ToggleableWrapper] =
					[
						ToggleableWrapper(Toggleable(title: "Sample 1", isActive: false)),
						ToggleableWrapper(Toggleable(title: "Sample 2", isActive: true)),
						ToggleableWrapper(Toggleable(title: "Sample 3", isActive: false)),
						ToggleableWrapper(Toggleable(title: "Sample 4", isActive: true)),
						ToggleableWrapper(Toggleable(title: "Sample 5", isActive: false)),
						ToggleableWrapper(Toggleable(title: "Sample 6", isActive: true)),
					]

	static	var previews :some View {
						List {
							ToggleableView(self.toggleableWrappers[0], togglePlacement: .leadingToggle)
							ToggleableView(self.toggleableWrappers[1], togglePlacement: .trailingToggle)
							ToggleableView(self.toggleableWrappers[2], togglePlacement: .leadingCheckmark)
							ToggleableView(self.toggleableWrappers[3], togglePlacement: .trailingCheckmark)
							ToggleableView(self.toggleableWrappers[4], togglePlacement: .leadingCheckmarkCircle)
							ToggleableView(self.toggleableWrappers[5], togglePlacement: .trailingCheckmarkCircle)
						}
							.padding()
					}
}
