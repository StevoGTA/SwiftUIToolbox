//
//  View+Extensions.swift
//  SwiftUI Toolbox
//
//  Created by Stevo Brock on 3/15/25.
//  Copyright © 2025 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: LocalizedAlertError
fileprivate struct LocalizedAlertError : LocalizedError {

	// MARK: Properties
	let	error :Error

	var	errorDescription :String? {
				(self.error as? LocalizedError)?.errorDescription ?? self.error.localizedDescription
			}
	var	recoverySuggestion :String? { (self.error as? LocalizedError)?.recoverySuggestion }

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init?(error :Error?) {
		// Validate
		guard let error else { return nil }

		// Store
		self.error = error
	}
}

//----------------------------------------------------------------------------------------------------------------------
// MARK: - View extension
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

	@ViewBuilder
	func errorAlert(error :Binding<Error?>, buttonTitle :String = "OK") -> some View {
		// Setup
		let	localizedAlertError = LocalizedAlertError(error: error.wrappedValue)

		alert(isPresented: Binding(get: { error.wrappedValue != nil }, set: { if !$0 { error.wrappedValue = nil } }),
				error: localizedAlertError) { _ in
			Button(buttonTitle) { error.wrappedValue = nil }
		} message: { error in
			Text(error.recoverySuggestion ?? "")
		}
	}
}
