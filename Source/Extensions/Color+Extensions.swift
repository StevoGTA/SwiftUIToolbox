//
//  Color+Extensions.swift
//  Crowd Noise
//
//  Created by Stevo on 11/2/20.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: Color extensions
extension Color {

	// MARK: Lifecycle methods
	init(hex :UInt) {
		// Setup
		let	alpha = Double((hex >> 24) & 0xFF) / 0xFF
		let	red = Double((hex >> 16) & 0xFF) / 0xFF
		let	green = Double((hex >> 8) & 0xFF) / 0xFF
		let	blue = Double((hex >> 0) & 0xFF) / 0xFF

		// Init
		self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
	}
}
