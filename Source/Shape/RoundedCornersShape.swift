//
//  RoundedCornersShape.swift
//  SwiftUI Toolbox
//
//  Created by Stevo on 7/20/20.
//  Copyright © 2020 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: RoundedCornersShape
struct RoundedCornersShape : Shape {

	// MARK: Properties
	private	let topLeftRadius: CGFloat
	private	let topRightRadius: CGFloat
	private	let bottomLeftRadius: CGFloat
	private	let bottomRightRadius: CGFloat

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(topLeftRadius :CGFloat = 0.0, topRightRadius :CGFloat = 0.0, bottomLeftRadius :CGFloat = 0.0,
			bottomRightRadius :CGFloat = 0.0) {
		// Store
		self.topLeftRadius = topLeftRadius
		self.topRightRadius = topRightRadius
		self.bottomLeftRadius = bottomLeftRadius
		self.bottomRightRadius = bottomRightRadius
	}

	// MARK: Shape methods
	//------------------------------------------------------------------------------------------------------------------
	func path(in rect: CGRect) -> Path {
		// Setup
		let width = rect.size.width
		let height = rect.size.height

		let topRightRadiusUse = min(min(self.topRightRadius, height / 2.0), width / 2.0)
		let topLeftRadiusUse = min(min(self.topLeftRadius, height / 2.0), width / 2.0)
		let bottomLeftRadiusUse = min(min(self.bottomLeftRadius, height / 2.0), width / 2.0)
		let bottomRightRadiusUse = min(min(self.bottomRightRadius, height / 2.0), width / 2.0)

		// Create path
		var path = Path()
		path.move(to: CGPoint(x: width / 2.0, y: 0.0))
		path.addLine(to: CGPoint(x: width - topRightRadiusUse, y: 0.0))
		path.addArc(center: CGPoint(x: width - topRightRadiusUse, y: topRightRadiusUse), radius: topRightRadiusUse,
				startAngle: Angle(degrees: -90.0), endAngle: Angle(degrees: 0.0), clockwise: false)
		path.addLine(to: CGPoint(x: width, y: height - bottomRightRadiusUse))
		path.addArc(center: CGPoint(x: width - bottomRightRadiusUse, y: height - bottomRightRadiusUse),
				radius: bottomRightRadiusUse, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 90.0),
				clockwise: false)
		path.addLine(to: CGPoint(x: bottomLeftRadiusUse, y: height))
		path.addArc(center: CGPoint(x: bottomLeftRadiusUse, y: height - bottomLeftRadiusUse),
				radius: bottomLeftRadiusUse, startAngle: Angle(degrees: 90.0), endAngle: Angle(degrees: 180.0),
				clockwise: false)
		path.addLine(to: CGPoint(x: 0, y: topLeftRadiusUse))
		path.addArc(center: CGPoint(x: topLeftRadiusUse, y: topLeftRadiusUse), radius: topLeftRadiusUse,
				startAngle: Angle(degrees: 180.0), endAngle: Angle(degrees: 270.0), clockwise: false)
		path.addLine(to: CGPoint(x: width / 2.0, y: 0.0))

		return path
	}
}
