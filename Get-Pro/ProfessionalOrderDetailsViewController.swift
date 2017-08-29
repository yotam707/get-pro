//
//  ProfessionalOrderDetailsViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 29/08/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class ProfessionalOrderDetailsViewController : BaseUIViewController, GetDataProtocol {
    
    
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var problemDescriptionTxtV: UITextView!
    @IBOutlet weak var userAvatarImgV: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    var orderRequestId : String = ""
    
    
    @IBAction func onDeclineButtonClick(_ sender: Any) {
        
    }
    
    @IBAction func onAcceptButtonClick(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load order request + loading animation
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onGetDataResponse(response: Response) {
        if response.status {
            // move to order confirmation controller
            self.performSegue(withIdentifier: "proInProgressOrderSeg", sender: self)
        }
    }
    
}
