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
    
    @IBOutlet weak var onlineAudioBtn: UIButton!
    @IBOutlet weak var localAudioBtn: UIButton!
    
    var timer: Timer?
    var localAudioPlayer: AVAudioPlayer?
    var onlineAudioPlayer: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideControls()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupVideo()
        setupLocalAudio()
        setupOnlineAudio()
        resetTimer()
        addGesture()
    }
    
    func setupVideo() {
        let url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        videoPlayer.configure(url: url)
        videoPlayer.play()
    }
    
    func setupLocalAudio() {
        let path = Bundle.main.path(forResource: "title.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            localAudioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("Ooops i can't play the song :( ")
        }
    }
    
    func setupOnlineAudio() {
        guard let url = URL.init(string: "http://listen.shoutcast.com/radiodeltalebanon") else { return print("Ooops i can't get the url :( ") }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")

            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        onlineAudioPlayer = AVPlayer(url: url)
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
    
    
    @IBAction func onlineAudioTapped(_ sender: Any) {
        if !onlineAudioPlayer!.isPlaying {
            onlineAudioBtn.setTitle("Pause Online Radio", for: .normal)
            onlineAudioPlayer?.play()
        } else {
            onlineAudioBtn.setTitle("Play Online Radio", for: .normal)
            onlineAudioPlayer?.pause()
        }
    }
    
    @IBAction func localAudioTapped(_ sender: Any) {
        if !localAudioPlayer!.isPlaying {
            localAudioBtn.setTitle("Pause Local Audio", for: .normal)
            localAudioPlayer?.play()
        } else {
            localAudioBtn.setTitle("Play Local Audio", for: .normal)
            localAudioPlayer?.stop()
        }
    }
    
    
}
