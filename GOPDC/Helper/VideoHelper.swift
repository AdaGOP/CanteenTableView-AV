//
//  VideoHelper.swift
//  GOPDC
//
//  Created by David Gunawan on 13/05/20.
//  Copyright © 2020 David Gunawan. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class VideoHelper {
    static func startMediaBrowser(delegate: UIViewController & UINavigationControllerDelegate & UIImagePickerControllerDelegate, sourceType: UIImagePickerController.SourceType) {
    guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
    
    let mediaUI = UIImagePickerController()
    mediaUI.sourceType = sourceType
    mediaUI.mediaTypes = [kUTTypeMovie as String]
    mediaUI.allowsEditing = true
    mediaUI.delegate = delegate
    delegate.present(mediaUI, animated: true, completion: nil)
  }
}
