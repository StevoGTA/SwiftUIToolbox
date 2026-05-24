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
						Text("\(String(self.toggleable.title))")
							.padding()
							.frame(maxWidth: .infinity)
							.background(self.toggleable.isActive ? Color.accentColor : Color(.systemGray5))
							.foregroundStyle(self.toggleable.isActive ? Color.white : Color.primary)
							.overlay(
								RoundedRectangle(cornerRadius: 12.0)
									.strokeBorder(self.toggleable.isActive ? Color.white : Color.clear,
											lineWidth: 2.0)
								)
							.clipShape(RoundedRectangle(cornerRadius: 12.0))
							.onTapGesture {
								// Toggle local state
								withAnimation {
									self.toggleable.isActive.toggle()
								}

								// Call proc
								self.noteUpdated()
							}
					}

	@ObservedObject
	private	var	toggleable :Toggleable

	private	let	updateProc :UpdateProc

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(_ toggleable :Toggleable, updateProc :UpdateProc? = nil) {
		// Store
		self.toggleable = toggleable

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
// MARK: ToggleableCard_Previews
struct ToggleableCard_Previews : PreviewProvider {

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
							ForEach(self.toggleables) {
								ToggleableCard($0)
							}
						}
							.padding()
					}
}
