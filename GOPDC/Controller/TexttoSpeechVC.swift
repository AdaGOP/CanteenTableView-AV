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
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    @IBAction func tapSpeakButton(_ sender: UIButton) {
//      checkPermissions()
        let utterance = AVSpeechUtterance(string: myTextView.text)
        utterance.voice = AVSpeechSynthesisVoice(language: "id-ID")
        utterance.rate = 0.5
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }

    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
