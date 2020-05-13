//
//  MediaPlaybackVC.swift
//  GOPDC
//
//  Created by David Gunawan on 13/05/20.
//  Copyright © 2020 David Gunawan. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MediaPlaybackVC: UIViewController {

    @IBOutlet weak var videoPlayer: VideoView!
    @IBOutlet weak var playPauseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideo()
        view.sendSubviewToBack(videoPlayer)
    }
    

    func setupVideo() {
        let url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        videoPlayer.configure(url: url)
        videoPlayer.play()
        
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        guard let player = videoPlayer else { return }
        if !player.isPlaying() {
            player.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
            player.pause()
        }
    }
    
}
