//
//  CenteringLayout.swift
//  SwiftUI Toolbox
//
//  Created by Stevo on 12/1/25.
//  Copyright © 2025 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: CenteringLayout
struct CenteringLayout<Content: View> : View {

	// MARK: Properties
			var	body :some View {
						HStack {
							Spacer()
							VStack {
								Spacer()
								self.content
								Spacer()
							}
							Spacer()
						}
					}

	private	let	content :Content

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(@ViewBuilder content: () -> Content) {
		// Store
		self.content = content()
	}
}
