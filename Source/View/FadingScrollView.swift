//
//  FadingScrollView.swift
//  SwiftUI Toolbox
//
//  Created by Stevo Brock on 9/10/26.
//  Copyright © 2026 Stevo Brock. All rights reserved.
//

import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: FadingScrollView
public struct FadingScrollView<Content : View> : View {

	// MARK: ContentBottomPreferenceKey
	private struct ContentBottomPreferenceKey : PreferenceKey {

		// MARK: Properties
		static	var	defaultValue :CGFloat { 0.0 }

		// MARK: Class methods
		//--------------------------------------------------------------------------------------------------------------
		static func reduce(value :inout CGFloat, nextValue :() -> CGFloat) { value = nextValue() }
	}

	// MARK: Properties
	public	var	body :some View {
						ScrollView {
							self.content()
								.background(
										GeometryReader { geometryReader in
											Color.clear
												.preference(key: ContentBottomPreferenceKey.self,
														value: geometryReader.frame(in: .named("scroll")).maxY)
										})
						}
							.coordinateSpace(name: "scroll")
							.background(
									GeometryReader { geometryReader in
										Color.clear
											.onAppear() { self.viewportHeight = geometryReader.size.height }
											.onChange(of: geometryReader.size.height)
													{ self.viewportHeight = $0 }
									})
							.onPreferenceChange(ContentBottomPreferenceKey.self) { self.contentBottom = $0 }
							.overlay(
									LinearGradient(colors: [self.fadeColor.opacity(0.0), self.fadeColor],
											startPoint: .top, endPoint: .bottom)
										.frame(height: self.fadeHeight)
										.frame(maxHeight: .infinity, alignment: .bottom)
										.opacity(self.fadeOpacity)
										.allowsHitTesting(false))
					}

	private	let	fadeHeight :CGFloat
	private	let	fadeColor :Color

	private	let	content :() -> Content

	@State
	private	var	contentBottom :CGFloat = 0.0

	@State
	private	var	viewportHeight :CGFloat = 0.0

	private	var	fadeOpacity :Double {
						// Full while more than a fade's worth remains below, gone at the end
						let	remaining = self.contentBottom - self.viewportHeight

						return Double(min(max(remaining / self.fadeHeight, 0.0), 1.0))
					}

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	public init(fadeHeight :CGFloat, fadeColor :Color, @ViewBuilder content :@escaping () -> Content) {
		// Store
		self.fadeHeight = fadeHeight
		self.fadeColor = fadeColor

		self.content = content
	}
}
