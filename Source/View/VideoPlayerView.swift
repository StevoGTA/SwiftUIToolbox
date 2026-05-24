//
//  VideoPlayerView.swift
//  SwiftUI Toolbox
//
//  Created by Stevo Brock on 4/24/26.
//  Copyright © 2026 Stevo Brock. All rights reserved.
//

import AVKit
import SwiftUI

//----------------------------------------------------------------------------------------------------------------------
// MARK: VideoPlayerView
struct VideoPlayerView : UIViewControllerRepresentable {

	// MARK: Properties
    let player	:AVPlayer

	// MARK: UIViewControllerRepresentable methods
	//------------------------------------------------------------------------------------------------------------------
    func makeUIViewController(context :Context) -> AVPlayerViewController {
    	// Setup AVPlayerViewController
        let	playerViewController = AVPlayerViewController()
        playerViewController.player = self.player
        playerViewController.view.backgroundColor = .clear
        playerViewController.contentOverlayView?.backgroundColor = .clear
        playerViewController.videoGravity = .resizeAspect

        return playerViewController
    }

	//------------------------------------------------------------------------------------------------------------------
    func updateUIViewController(_ playerViewController :AVPlayerViewController, context :Context) {
    	// Update
        playerViewController.player = self.player
    }
}
