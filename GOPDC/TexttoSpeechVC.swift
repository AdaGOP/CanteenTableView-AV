//
//  TexttoSpeechVC.swift
//  GOPDC
//
//  Created by Haryanto Salim on 13/05/20.
//  Copyright © 2020 David Gunawan. All rights reserved.
//

import UIKit
import AVFoundation

class TexttoSpeechVC: UIViewController {

    @IBOutlet weak var myTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func tapSpeakButton(_ sender: UIButton) {
    
//        checkPermissions()
        let utterance = AVSpeechUtterance(string: myTextView.text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.5
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
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
