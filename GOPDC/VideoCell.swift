//
//  VideoCell.swift
//  GOPDC
//
//  Created by David Gunawan on 13/05/20.
//  Copyright © 2020 David Gunawan. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet weak var videoThumbnail: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
