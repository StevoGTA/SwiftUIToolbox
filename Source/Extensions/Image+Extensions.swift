//
//  Image+Extensions.swift
//  SwiftUI Toolbox
//
//  Created by Stevo Brock on 3/21/26.
//  Copyright © 2026 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: PlatformImage
#if os(iOS)
	typealias PlatformImage = UIImage
#elseif os(macOS)
	typealias PlatformImage = NSImage
#endif

//----------------------------------------------------------------------------------------------------------------------
// MARK: Image extensions
extension Image {

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(platformImage: PlatformImage) {
		// Init
		#if os(iOS)
			self.init(uiImage: platformImage)
		#elseif os(macOS)
			self.init(nsImage: platformImage)
		#endif
	}
}
