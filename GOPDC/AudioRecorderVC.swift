//
//  AudioRecorderVC.swift
//  GOPDC
//
//  Created by Haryanto Salim on 13/05/20.
//  Copyright © 2020 David Gunawan. All rights reserved.
//

import UIKit
import AVFoundation

class AudioRecorderVC: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    
    var avRecorder: AVAudioRecorder?
    var avPlayer: AVAudioPlayer?
    
    let audioSession = AVAudioSession.sharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.isEnabled = false
        stopButton.setTitleColor(.red, for: .normal)
        playButton.isEnabled = false
        playButton.setTitleColor(.red, for: .normal)

        // Do any additional setup after loading the view.
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            audioSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.dismiss(animated: true) {
                            
                        }
                    } else {
                        // failed to record
                    }
                }
            }
        } catch {
            // failed to record
        }
        
    }
    
    func setURL()->URL{
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let docDir = dirPath[0]
        
        let stringPath = docDir.appending("/sound.m4a")
        
        let url = URL(fileURLWithPath: stringPath)
        
        return url
    }
    
//    func loadRecordingUI() {
//        recordButton.isEnabled = true
//        playButton.isEnabled = false
//        recordButton.setTitle("Tap to Record", for: .normal)
//        recordButton.addTarget(self, action: #selector(recordAudioButtonTapped), for: .touchUpInside)
//        view.addSubview(recordButton)
//    }
    
    
    @IBAction func tapRecordButton(_ sender: UIButton) {
        let settings = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 12000,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.low.rawValue
        ]
        
        do{
            avRecorder = try AVAudioRecorder(url: setURL(), settings: settings)
            avRecorder?.delegate = self
            recordButton.isEnabled = false
            recordButton.setTitleColor(.red, for: .normal)
            stopButton.isEnabled = true
            stopButton.setTitleColor(.systemBlue, for: .normal)
            avRecorder?.record()
        }catch{
            avRecorder?.stop()
            recordButton.isEnabled = true
            recordButton.setTitleColor(.systemBlue, for: .normal)
            stopButton.isEnabled = false
            stopButton.setTitleColor(.red, for: .normal)
            avRecorder = nil
        }
    }
    
    @IBAction func tapStopButton(_ sender: UIButton) {
        if avRecorder != nil {
            avRecorder?.stop()
            recordButton.isEnabled = true
            recordButton.setTitleColor(.systemBlue, for: .normal)
            stopButton.isEnabled = false
            stopButton.setTitleColor(.red, for: .normal)
            playButton.isEnabled = true
            playButton.setTitleColor(.systemBlue, for: .normal)
            avRecorder = nil
        }
        
        if avPlayer != nil {
            avPlayer?.stop()
            playButton.isEnabled = true
            playButton.setTitleColor(.systemBlue, for: .normal)
            recordButton.isEnabled = true
            recordButton.setTitleColor(.systemBlue, for: .normal)
            stopButton.isEnabled = false
            stopButton.setTitleColor(.red, for: .normal)
            avPlayer = nil
        }
    }
    
    @IBAction func tapPlayButton(_ sender: UIButton) {
        var error: NSError?
        do {
            avPlayer = try AVAudioPlayer(contentsOf: setURL() as URL)
        } catch let error1 as NSError {
            error = error1
            avPlayer = nil
        }
        
        if let err = error {
            print("AVAudioPlayer error: \(err.localizedDescription)")
        } else {
            avPlayer?.delegate = self
            avPlayer?.prepareToPlay()
            avPlayer?.volume = 10.0
        }
        
        playButton.isEnabled = false
        playButton.setTitleColor(.red, for: .normal)
        recordButton.isEnabled = false
        recordButton.setTitleColor(.red, for: .normal)
        stopButton.isEnabled = true
        stopButton.setTitleColor(.systemBlue, for: .normal)
        avPlayer?.play()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
