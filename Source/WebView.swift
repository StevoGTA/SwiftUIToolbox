//
//  WebView.swift
//  SwiftUI Toolbox
//
//  Created by Stevo on 7/21/20.
//  Copyright © 2020 Stevo Brock. All rights reserved.
//

import SwiftUI
import WebKit

//----------------------------------------------------------------------------------------------------------------------
// MARK: WebView
struct WebView : UIViewRepresentable {

	// MARK: Properties
	private	let	request :URLRequest

	// MARK: Lifecycle methods
	//------------------------------------------------------------------------------------------------------------------
	init(request :URLRequest) {
		// Store
		self.request = request
	}

	// MARK: UIViewRepresentable methods
	//------------------------------------------------------------------------------------------------------------------
	func makeUIView(context :Context) -> some UIView { WKWebView() }

	//------------------------------------------------------------------------------------------------------------------
	func updateUIView(_ uiView :UIViewType, context :Context) { (uiView as! WKWebView).load(self.request) }
}

//----------------------------------------------------------------------------------------------------------------------
// MARK: - WebView_Previews
struct WebView_Previews : PreviewProvider {

	// MARK: Properties
    static	var	previews :some View {
						Group {
							WebView(request: URLRequest(url: URL(string: "https://www.apple.com")!))
							WebView(request: URLRequest(url: URL(string: "https://www.apple.com")!))
								.previewDevice("iPhone SE (2nd generation)")
						}
					}
}
