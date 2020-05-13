//
//  RecordVideoVC.swift
//  GOPDC
//
//  Created by David Gunawan on 13/05/20.
//  Copyright © 2020 David Gunawan. All rights reserved.
//

import UIKit
import MobileCoreServices

class RecordVideoVC: UIViewController, UINavigationControllerDelegate {
    
    @IBAction func recordTapped(_ sender: AnyObject) {
        VideoHelper.startMediaBrowser(delegate: self, sourceType: .camera)
    }
    
    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
      let title = (error == nil) ? "Success" : "Error"
      let message = (error == nil) ? "Video was saved" : "Video failed to save"
      
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
      present(alert, animated: true, completion: nil)
    }
}

extension RecordVideoVC: UIImagePickerControllerDelegate {
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
      
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType.rawValue] as? String,
        mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL.rawValue] as? URL,
        UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
        else { return }
      
      // Handle a movie capture
      UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
    }
}
