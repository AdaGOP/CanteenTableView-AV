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
    @IBOutlet weak var controlLayerView: UIView!
    @IBOutlet weak var playPauseButton: UIButton!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupVideo()
        resetTimer()
        addGesture()
    }
    
    func setupVideo() {
        let url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        videoPlayer.configure(url: url)
        videoPlayer.play()
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(hideControls), userInfo: nil, repeats: false)
    }
    
    func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleControls))
        controlLayerView.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideControls() {
        playPauseButton.isHidden = true
    }
    
    @objc func toggleControls() {
        playPauseButton.isHidden = !playPauseButton.isHidden
        resetTimer()
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
