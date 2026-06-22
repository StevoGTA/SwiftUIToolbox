//
//  HostingTableViewCell.swift
//  SwiftUI Toolbox
//
//  Created by Stevo Brock on 6/22/26.
//  Copyright © 2026 Stevo Brock. All rights reserved.
//

import SwiftUI
import UIKit

//----------------------------------------------------------------------------------------------------------------------
// MARK: HostingTableViewCell
public class HostingTableViewCell<Content : View> : UITableViewCell {

	// MARK: Properties
	private	var	hostingController :UIHostingController<Content>?

	// MARK: Instance methods
	//------------------------------------------------------------------------------------------------------------------
	public func configure(rootView :Content, parent :UIViewController) {
		// Check if already have UIHostingController
		if self.hostingController != nil {
			// Already have Hosting Controller
			self.hostingController!.rootView = rootView
		} else {
			// Create UIHostingController
			self.hostingController = UIHostingController(rootView: rootView)
			self.hostingController!.view.backgroundColor = .clear

			// Add to the view hierarchy
			parent.addChild(self.hostingController!)
			self.contentView.addSubview(self.hostingController!.view)

			// Setup constraints
			self.hostingController!.view.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate(
					[
						self.hostingController!.view.topAnchor.constraint(equalTo: contentView.topAnchor),
						self.hostingController!.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
						self.hostingController!.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
						self.hostingController!.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
					])

			// Did move
			self.hostingController!.didMove(toParent: parent)
		}
	}
}
