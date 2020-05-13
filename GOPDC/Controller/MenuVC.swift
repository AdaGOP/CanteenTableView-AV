//
//  MenuVC.swift
//  GOPDC
//
//  Created by David Gunawan on 12/05/20.
//  Copyright © 2020 David Gunawan. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MenuVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let AVMenu = ["Media Playback","Media Capture","Audio Recorder", "Text to Speech"]
    let videoUrl = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "NormalCell", bundle: nil), forCellReuseIdentifier: getIdentifier(forSection: 0))
        tableView.register(UINib(nibName: "VideoCell", bundle: nil), forCellReuseIdentifier: getIdentifier(forSection: 1))
    }
    
    func getIdentifier(forSection section:Int) -> String {
        switch section {
        case 0:
            return "normalCell"
        case 1:
            return "videoCell"
        default:
            return "videoCell"
        }
    }
    
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async {
            let asset = AVAsset(url: url)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            let thumbnailTime = CMTimeMake(value: 20, timescale: 1)
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumbnailTime, actualTime: nil)
                let thumbImage = UIImage(cgImage: cgThumbImage)
                DispatchQueue.main.async {
                    completion(thumbImage)
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}


extension MenuVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return AVMenu.count
        case 1:
            return 1
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: getIdentifier(forSection: indexPath.section), for: indexPath) as? NormalCell {
                cell.menuLabel.text = AVMenu[indexPath.row]
                return cell
            } else {
                return NormalCell()
            }
        case 1 :
            if let cell = tableView.dequeueReusableCell(withIdentifier: getIdentifier(forSection: indexPath.section), for: indexPath) as? VideoCell {
                self.getThumbnailImageFromVideoUrl(url: URL(string: videoUrl)!) { (thumbImage) in
                    cell.videoThumbnail.image = thumbImage
                }
                cell.videoSubtitle.text = "Test \(indexPath.row)"
                cell.videoTitle.text = "WWDC Video on AVFoundation"
                return cell
            } else {
                return VideoCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Audio"
        case 1:
            return "Video"
        default:
            return "Audio"
        }
    }
}

extension MenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 44
        case 1:
            return 100
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: AVMenu[indexPath.row], sender: self)
        } else {
            playVideo()
        }
    }
    
    func playVideo() {
        let player = AVPlayer(url: URL(string: videoUrl)!)
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true) {
            vc.player?.play()
        }
    }
}



