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
    var orderReq = OrderRequest()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        professionalNameLbl.text = proOrder.name
        self.setViewColor(view: self.view, color: K.Colors.darkGray)
        self.setViewColor(view: getProBtn, color: K.Colors.darkRed)
        professionalAvatarImgV.image = UIImage(named: "avatar.png")
        professionalAvatarImgV.layer.cornerRadius = 40
        professionalAvatarImgV.layer.borderColor = UIColor.white.cgColor
        professionalAvatarImgV.layer.borderWidth = 3
        let str = "rating_img_\(proOrder.rating).png"
        professionalRatingImgV.image = UIImage(named: str)
    }
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onGetProButtonClick(_ sender: Any) {
        
        self.loadingAI.startAnimating()
        self.setViewState(isEnabled: false)
    
        let order = UserOrderView()
        order.categoryName = orderReq.categoryName
        order.orderRequstId = orderReq.id
        //OrdersManager.confirmOrderByUser(userOrder: <#T##UserOrderView#>, view: <#T##GetDataProtocol#>)
        
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
