//
//  AnimatedImageView.swift
//  SwiftUI Toolbox
//
//  Created by Stevo on 7/21/20.
//  Copyright © 2020 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: FrameIndex
private class FrameIndex : ObservableObject {

	// MARK: Types
	typealias CompletionProc = () -> Void

	// MARK: Properties
	@Published
			var	value = 0

	private	let	completionFrameIndex :Int

	private	let	completionProc :CompletionProc

	private	var	timer :Timer!

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(framerate :Double, completionFrameIndex :Int, completionProc :@escaping CompletionProc) {
		// Store
		self.completionFrameIndex = completionFrameIndex

		self.completionProc = completionProc

		// Setup
		self.timer =
				Timer.scheduledTimer(withTimeInterval: 1.0 / framerate, repeats: true)
					{ [unowned self] in
						// Update value
						self.value += 1

						// Check value
						if self.value == self.completionFrameIndex {
							// Done
							$0.invalidate()

							// Call proc
							self.completionProc()
						}
					}
	}

	//------------------------------------------------------------------------------------------------------------------
	deinit {
		self.timer.invalidate()
	}
}

//----------------------------------------------------------------------------------------------------------------------
// MARK: - AnimatedImageView
struct AnimatedImageView : View {

	// MARK: Types
	typealias CompletionProc = () -> Void

	// MARK: Properties
	private	let	images :[Image]

	@ObservedObject
	private	var	frameIndex :FrameIndex

			var	body :some View {
						GeometryReader { geometry in
							self.images[self.frameIndex.value % self.images.count]
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: geometry.size.width, height: geometry.size.height)
						}
					}

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(images :[Image], framerate :Double, completionProc :@escaping CompletionProc) {
		// Store
		self.images = images

		// Setup
		self.frameIndex =
				FrameIndex(framerate: framerate, completionFrameIndex: images.count - 1, completionProc: completionProc)
	}
}
