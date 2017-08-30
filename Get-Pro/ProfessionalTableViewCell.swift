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
    @IBOutlet weak var avatarImageImgV: UIImageView!
    @IBOutlet weak var acceptProfessionalBtn: UIButton!
    @IBOutlet weak var ratingImgV: UIImageView!
    
    weak var professional = ProfessionalOrder()
    weak var orderRequest = OrderRequest()
    weak var acceptClickDelegate: AcceptUserDelegate?
    
    
    @IBAction func onAcceptProfessionalBtnClick(_ sender: Any) {
        acceptClickDelegate?.onUserAcceptBtnClick(orderRequest: orderRequest!, professional: professional!);
    }
    
}
