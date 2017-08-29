//
//  ProfessionalOrderDetailsViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 29/08/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class ProfessionalOrderDetailsViewController : BaseUIViewController, GetDataProtocol {
    
    @IBOutlet weak var loadingAI: UIActivityIndicatorView!
    
    @IBOutlet weak var bottomV: UIView!
    @IBOutlet weak var separatorV: UIView!
    @IBOutlet weak var problemDescTitleLbl: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var declineBtn: UIBarButtonItem!
    
    @IBOutlet weak var problemDescriptionTxtV: UITextView!
    @IBOutlet weak var userAvatarImgV: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    var orderRequestId : String = ""
    var orderDetails = ProfessionalOrderDetailsView()
    
    @IBAction func onDeclineButtonClick(_ sender: Any) {
        
    }
    
    @IBAction func onAcceptButtonClick(_ sender: Any) {
        self.loadingAI.startAnimating()
        self.loadingAI.isHidden = false
        self.acceptButton.isEnabled = false
        self.declineBtn.isEnabled = false
        OrdersManager.confirmOrderByProfessional(orderProDetails: orderDetails, view: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewState(isHidden: true)
        self.loadingAI.startAnimating()
        self.loadingAI.isHidden = false
       
        OrdersManager.getProfessionalOrderDetails(orderRequsetId: orderRequestId, view: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setViewState(isHidden: Bool){
        self.acceptButton.isHidden = isHidden
        self.userAvatarImgV.isHidden = isHidden
        self.problemDescriptionTxtV.isHidden = isHidden
        self.userNameLbl.isHidden = isHidden
        self.separatorV.isHidden = isHidden
        self.problemDescTitleLbl.isHidden = isHidden
        self.bottomV.isHidden = isHidden
    }
    
    func onGetDataResponse(response: Response) {
        switch response.actionType {
        case K.ActionTypes.getProfessionalOrderDetails:
            //load view
            if response.status {
                
                self.orderDetails = (response.entities as! [ProfessionalOrderDetailsView])[0]
                userNameLbl.text = orderDetails.userName
                userAvatarImgV.image = UIImage (named: "avatar.png")
                userAvatarImgV.layer.cornerRadius = 60
                userAvatarImgV.layer.borderColor = UIColor.white.cgColor
                userAvatarImgV.layer.borderWidth = 3
                problemDescriptionTxtV.text = orderDetails.problemDescription
                
                self.loadingAI.stopAnimating()
                self.loadingAI.isHidden = true
                self.setViewState(isHidden: false)
            }
            else {
                //alert
            }
            break
        default:
            //confirmed by Pro
            if response.status {
                self.loadingAI.stopAnimating()
                self.loadingAI.isHidden = true
                
                // move to order confirmation controller
                self.performSegue(withIdentifier: "proInProgressOrderSeg", sender: self)
            }
            else {
                //alert
            }
        }
    }
    
}
