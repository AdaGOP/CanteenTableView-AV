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
        let nib = UINib(nibName: "VideoCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "videoCell")
    }
}


extension MenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! VideoCell
        cell.videoSubtitle.text = "Test \(indexPath.row)"
        cell.videoTitle.text = "WWDC Video on AVFoundation"
        return cell
    }
}

extension MenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

