//
//  View+Extensions.swift
//  SwiftUI Toolbox
//
//  Created by Stevo Brock on 3/15/25.
//  Copyright © 2025 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: View extension
extension View {

	// MARK: Properties
	var	isInPreview :Bool { ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" }

	// MARK: Instance methods
	//------------------------------------------------------------------------------------------------------------------
	/// Applies the given transform if the given condition evaluates to `true`.
	/// - Parameters:
	///   - condition: The condition to evaluate.
	///   - transform: The transform to apply to the source `View`.
	/// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
	@ViewBuilder
	func `if`<Content :View>(_ condition :@autoclosure () -> Bool, transform :(Self) -> Content) -> some View {
		// Check condition
		if condition() {
			// Apply transform
			transform(self)
		} else {
			// Do not apply transform
			self
		}
	}
}
