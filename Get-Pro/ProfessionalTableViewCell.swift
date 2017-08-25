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
    
    weak var professional = Professional()
    weak var acceptProfessionalClickDelegate: AcceptProfessionalDelegate?
    
    
    @IBAction func onAcceptProfessionalBtnClick(_ sender: Any) {
        acceptProfessionalClickDelegate?.onProfessionalAcceptBtnClick(potentialOrderRequestId: (self.professional?.id)!);
    }
    
    
    /*@IBOutlet weak var professionalNameLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var avatarImageImgV: UIImageView!
    @IBOutlet weak var acceptProfessionalBtn: UIButton!
    
    
    
    
    
    
    weak var professional = Professional()
    weak var acceptProfessionalClickDelegate: AcceptProfessionalDelegate?
    
    
    @IBAction func onAcceptProfessionalBtnClick(_ sender: Any) {
        acceptProfessionalClickDelegate?.onProfessionalAcceptBtnClick(potentialOrderRequestId: (self.professional?.id)!);
    }*/
    
}
