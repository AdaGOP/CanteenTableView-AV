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
        if section == 0 {
            return 3
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: getIdentifier(forSection: indexPath.section), for: indexPath) as! NormalCell
            cell.menuLabel.text = "Favorites"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: getIdentifier(forSection: indexPath.section), for: indexPath) as! VideoCell
            cell.videoSubtitle.text = "Test \(indexPath.row)"
            cell.videoTitle.text = "WWDC Video on AVFoundation"
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Audio"
        } else {
            return "Video"
        }
    }
}

extension MenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44
        } else {
            return 100
        }
        
    }
}



