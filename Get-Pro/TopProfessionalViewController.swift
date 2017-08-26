//
//  TopProfessionalViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 08/08/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation
import UIKit

class TopProfessionalViewController : BaseUIViewController {
    
    @IBOutlet weak var getProBtn: UIButton!
    @IBOutlet weak var moreProfessionalsBtn: UIBarButtonItem!
    @IBOutlet weak var backBtn: UIBarButtonItem!
    @IBOutlet weak var professionalNameLbl: UILabel!
    @IBOutlet weak var professionalAvatarImgV: UIImageView!
    @IBOutlet weak var professionalRatingImgV: UIImageView!
    @IBOutlet weak var loadingAI: UIActivityIndicatorView!
    
    var proOrder = ProfessionalOrder()

    
    @IBAction func onBackButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onGetProButtonClick(_ sender: Any) {
        
        self.loadingAI.startAnimating()
        self.setViewState(isEnabled: false)
    
        
        // move to top order confirmation controller
        self.performSegue(withIdentifier: "acceptTopProfessionalSeg", sender: self)
    }
    
    @IBAction func onMoreProfessionalCuttonClick(_ sender: Any) {
        // move to professionals controller
        self.performSegue(withIdentifier: "professionalSeg", sender: self)
    }
    
    func setViewState(isEnabled:Bool){
        getProBtn.isEnabled = isEnabled
        moreProfessionalsBtn.isEnabled = isEnabled
        backBtn.isEnabled = isEnabled
    }
}
