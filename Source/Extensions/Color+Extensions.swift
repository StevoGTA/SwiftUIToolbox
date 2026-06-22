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
}
