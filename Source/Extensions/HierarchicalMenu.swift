//
//  HierarchicalMenu.swift
//  SwiftUI Toolbox
//
//  Created by Stevo Brock on 3/21/26.
//  Copyright © 2026 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: HierarchicalMenu
struct HierarchicalMenu : View {

	// MARK: Types
	typealias AddProc = (_ parentPrefix :String?) -> Void
	typealias SelectProc = (_ item :String) -> Void

	// MARK: Properties
			var	body :some View {
						// Filter items based on given prefix
						let	filtered = items.filter({ $0.hasPrefix(prefix.joined(separator: "/")) })

						// Get unique next components
						let	nextComponents =
									Set(filtered.compactMap({ item -> String? in
										// Get parts
										let	parts = item.split(separator: "/").map(String.init)

										return (parts.count > prefix.count) ? parts[prefix.count] : nil
									}))

						// Iterate next components
						ForEach(Array(nextComponents).sorted().reversed(), id: \.self) { component in
							// Setup
							let	currentPath = prefix + [component]
							let	fullPath = currentPath.joined(separator: "/")
							let	hasChildren =
										filtered.contains(
												where: { item in
													// Setup
													let parts = item.split(separator: "/").map(String.init)

													return (parts.count > currentPath.count) && item.hasPrefix(fullPath)
												})

							// Check if has children
							if hasChildren || (self.addProc != nil) {
								// Compose Menu with children
								Menu {
									HierarchicalMenu(items, selectParentPrefix: self.selectParentPrefix,
											prefix: currentPath, selectProc: selectProc)

									if let selectParentPrefix = self.selectParentPrefix {
										// Divider
										Divider()

										// Check if have addProc
										if let addProc = self.addProc {
											// Add item
											Button {
												// Call proc
												addProc(fullPath)
											} label: {
												Label("Add...", systemImage: "folder.badge.plus")
											}
										}

										// "Use" item
										Button {
											self.selectProc(fullPath)
										} label: {
											Label("\(selectParentPrefix) \"\(component)\"",
													systemImage: "checkmark.circle")
										}
									}
								} label: { Text(component) }
							} else {
								// Menu item
								Button(component) { self.selectProc(fullPath) }
							}
						}

						// Check if have addProc
						if self.prefix.isEmpty, let addProc = self.addProc {
							// Divider
							Divider()

							// Add item
							Button {
								// Call proc
								addProc("")
							} label: {
								Label("Add...", systemImage: "folder.badge.plus")
							}
						}
					}

	@State
	private	var	items: Set<String>

	private	let	selectParentPrefix :String?
	private	let	prefix: [String]

	private	let	addProc :AddProc?
	private	let	selectProc :SelectProc

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(_ items :Set<String>, selectParentPrefix :String?, addProc :AddProc? = nil, selectProc :@escaping SelectProc) {
		// Store
		self.items = items
		self.selectParentPrefix = selectParentPrefix

		self.addProc = addProc
		self.selectProc = selectProc

		// Setup
		self.prefix = []
	}

	//------------------------------------------------------------------------------------------------------------------
	private init(_ items :Set<String>, selectParentPrefix :String?, prefix :[String],
			addProc :AddProc? = nil, selectProc :@escaping SelectProc) {
		// Store
		self.items = items
		self.selectParentPrefix = selectParentPrefix
		self.prefix = prefix

		self.addProc = addProc
		self.selectProc = selectProc
	}
}
