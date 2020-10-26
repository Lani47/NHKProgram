//
//  NHKProgramCell.swift
//  NHKproject
//
//  Created by cmStudent on 2020/08/21.
//  Copyright © 2020 20CM0103. All rights reserved.
//

import UIKit

class NHKProgramCell: UITableViewCell {
    
    
    @IBOutlet weak var serviceLogoimage: UIImageView!
    
    @IBOutlet weak var programTitleLavel: UILabel!
    
    @IBOutlet weak var programSubtitleLavel: UILabel!
    
    @IBOutlet weak var programStertLaval: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
