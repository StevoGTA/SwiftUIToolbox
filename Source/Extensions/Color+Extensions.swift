//
//  Color+Extensions.swift
//  SwiftUI Toolbox
//
//  Created by Stevo Brock on 11/2/20.
//  Copyright © 2020 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: Color extensions
public extension Color {

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(hex :UInt) {
		// Setup
		let	alpha = Double((hex >> 24) & 0xFF) / 0xFF
		let	red = Double((hex >> 16) & 0xFF) / 0xFF
		let	green = Double((hex >> 8) & 0xFF) / 0xFF
		let	blue = Double((hex >> 0) & 0xFF) / 0xFF

		// Init
		self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
	}

	//------------------------------------------------------------------------------------------------------------------
	init?(hex :String) {
		// Setup
		let	string = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex

		// Validate and parse
		guard (string.count == 6) || (string.count == 8), let value = UInt(string, radix: 16) else { return nil }

		// Extract channels - assume fully opaque when no alpha is specified (6 hex digits)
		let	alpha = (string.count == 8) ? Double((value >> 24) & 0xFF) / 0xFF : 1.0
		let	red = Double((value >> 16) & 0xFF) / 0xFF
		let	green = Double((value >> 8) & 0xFF) / 0xFF
		let	blue = Double((value >> 0) & 0xFF) / 0xFF

		// Init
		self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
	}
}
