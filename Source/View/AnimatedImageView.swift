//
//  AnimatedImageView.swift
//  SwiftUI Toolbox
//
//  Created by Stevo on 7/21/20.
//  Copyright © 2020 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: AnimatedImageView
struct AnimatedImageView : View {

	// MARK: Properties
			var	body :some View {
						GeometryReader { geometry in
							self.images[self.frameIndex.value % self.images.count]
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: geometry.size.width, height: geometry.size.height)
						}
					}

	private	let	images :[Image]

	@ObservedObject
	private	var	animationTimer :AnimationTimer

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(images :[Image], framerate :Double, completionProc :@escaping () -> Void) {
		// Store
		self.images = images

		// Setup
		self.animationTimer =
				AnimationTimer(framerate: framerate, completionFrameIndex: images.count - 1,
						completionProc: completionProc)
	}
}
