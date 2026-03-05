//
//  ToggleableCard.swift
//  SwiftUI Toolbox
//
//  Created by Stevo Brock on 3/5/25.
//  Copyright © 2026 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: ToggleableCard
struct ToggleableCard : View {

	// MARK: Procs
	typealias UpdateProc = () -> Void

	// MARK: Properties
			var	body :some View {
						Text("\(String(self.toggleableWrapper.title))")
							.padding()
							.frame(maxWidth: .infinity)
							.background(self.toggleableWrapper.isActive ? Color.accentColor : Color(.systemGray5))
							.foregroundStyle(self.toggleableWrapper.isActive ? Color.white : Color.primary)
							.overlay(
								RoundedRectangle(cornerRadius: 12.0)
									.strokeBorder(self.toggleableWrapper.isActive ? Color.white : Color.clear,
											lineWidth: 2.0)
								)
							.clipShape(RoundedRectangle(cornerRadius: 12.0))
							.onTapGesture {
								// Toggle local state
								withAnimation {
									self.toggleableWrapper.isActive.toggle()
								}

								// Call proc
								self.noteUpdated()
							}
					}

	@ObservedObject
	private	var	toggleableWrapper :ToggleableWrapper

	private	let	updateProc :UpdateProc

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(_ toggleableWrapper :ToggleableWrapper, updateProc :UpdateProc? = nil) {
		// Store
		self.toggleableWrapper = toggleableWrapper

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
// MARK: ToggleableCard_Previews
struct ToggleableCard_Previews : PreviewProvider {

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
							ForEach(self.toggleableWrappers) {
								ToggleableCard($0)
							}
						}
							.padding()
					}
}
