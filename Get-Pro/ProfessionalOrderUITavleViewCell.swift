//
//  ProfessionalOrderUITavleViewCell.swift
//  Get-Pro
//
//  Created by Eliran Levy on 29/08/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class ProfessionalOrderUITavleViewCell : UITableViewCell {
    
    
    @IBOutlet weak var userAvatarImgV: UIImageView!
    @IBOutlet weak var userCityLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var acceptOrderBtn: UIButton!
    weak var proOrderDetails = ProfessionalOrderDetailsView()
    weak var acceptClickDelegate: AcceptProfessionalDelegate?

    
    @IBAction func onAcceptOrderButtonClick(_ sender: Any) {
        acceptClickDelegate?.onProfessionalAcceptBtnClick(orderDetails: proOrderDetails!)
    }
    
}
