//
//  FlowLayout.swift
//  SwiftUI Toolbox
//
//  Created by Claude on 7/14/26.
//  Copyright © 2026 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: FlowLayout
// Lays subviews left-to-right at their natural size, wrapping to a new line when the next subview would overflow the
//	proposed width — like text wrapping.  Reports only the size it actually uses, so it hugs its content.
@available(iOS 16.0, macOS 13.0, *)
struct FlowLayout : Layout {

	// MARK: Properties
	private	let	horizontalSpacing :CGFloat
	private	let	verticalSpacing :CGFloat

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(horizontalSpacing :CGFloat = 8.0, verticalSpacing :CGFloat = 8.0) {
		// Store
		self.horizontalSpacing = horizontalSpacing
		self.verticalSpacing = verticalSpacing
	}

	// MARK: Layout methods
	//------------------------------------------------------------------------------------------------------------------
	func sizeThatFits(proposal :ProposedViewSize, subviews :Subviews, cache :inout Void) -> CGSize {
		// Size is whatever the arrangement uses
		return arrangement(proposal: proposal, subviews: subviews).size
	}

	//------------------------------------------------------------------------------------------------------------------
	func placeSubviews(in bounds :CGRect, proposal :ProposedViewSize, subviews :Subviews, cache :inout Void) {
		// Setup
		let	offsets = arrangement(proposal: proposal, subviews: subviews).offsets

		// Place each subview at its computed offset, at its natural size
		subviews.enumerated().forEach() {
			// Place
			$1.place(at: CGPoint(x: bounds.minX + offsets[$0].x, y: bounds.minY + offsets[$0].y), anchor: .topLeading,
					proposal: .unspecified)
		}
	}

	// MARK: Private methods
	//------------------------------------------------------------------------------------------------------------------
	private func arrangement(proposal :ProposedViewSize, subviews :Subviews) -> (offsets :[CGPoint], size :CGSize) {
		// Setup
		let	maxWidth = proposal.width ?? .infinity

		var	offsets :[CGPoint] = []
		var	currentX :CGFloat = 0.0
		var	currentY :CGFloat = 0.0
		var	lineHeight :CGFloat = 0.0
		var	usedWidth :CGFloat = 0.0

		// Walk the subviews, wrapping when the next one would overflow the current line
		for subview in subviews {
			// Measure at natural size
			let	size = subview.sizeThatFits(.unspecified)

			// Check if have enough space for this subview
			if (currentX > 0.0) && ((currentX + size.width) > maxWidth) {
				// Start a new row
				currentX = 0.0
				currentY += lineHeight + self.verticalSpacing
				lineHeight = 0.0
			}

			// Add offset
			offsets.append(CGPoint(x: currentX, y: currentY))

			// Update
			currentX += size.width + self.horizontalSpacing
			lineHeight = max(lineHeight, size.height)
			usedWidth = max(usedWidth, currentX - self.horizontalSpacing)
		}

		return (offsets, CGSize(width: usedWidth, height: currentY + lineHeight))
	}
}
