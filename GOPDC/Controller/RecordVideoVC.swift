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
    
    let videoFileName = "/video.mp4"
    
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
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedVideo:URL = (info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.mediaURL.rawValue)] as? URL) {
            // Save video to the main photo album
            UISaveVideoAtPathToSavedPhotosAlbum(selectedVideo.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
            
            // Save the video to the app directory so we can play it later
            let videoData = try? Data(contentsOf: selectedVideo)
            let paths = NSSearchPathForDirectoriesInDomains(
                FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let documentsDirectory: URL = URL(fileURLWithPath: paths[0])
            let dataPath = documentsDirectory.appendingPathComponent(videoFileName)
            try! videoData?.write(to: dataPath, options: [])
        }
        dismiss(animated: true, completion: nil)
    }
}
