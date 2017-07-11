//
//  ProfessionalTableViewCell.swift
//  Get-Pro
//
//  Created by Eliran Levy on 07/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation
import UIKit

class ProfessionalTableViewCell :UITableViewCell {
    
    @IBOutlet weak var professionalNameLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var avatarImageImgV: UIImageView!
    @IBOutlet weak var acceptProfessionalBtn: UIButton!
    
    @IBAction func onAcceptProfessionalBtnClick(_ sender: Any) {
    }
    
}
