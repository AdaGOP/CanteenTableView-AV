//
//  MenuVC.swift
//  GOPDC
//
//  Created by David Gunawan on 12/05/20.
//  Copyright © 2020 David Gunawan. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let AVMenu = ["Media Playback","Media Capture","Audio Recorder", "Text to Speech"]
    
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
}



