//
//  TopProfessionalViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 08/08/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation
import UIKit

class TopProfessionalViewController : BaseUIViewController, GetDataProtocol {
    
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
        
        loadingAI.stopAnimating()
        loadingAI.isHidden = true
        professionalNameLbl.text = proOrder.name
        self.setViewColor(view: self.view, color: K.Colors.darkGray)
        self.setViewColor(view: getProBtn, color: K.Colors.darkRed)
        AppManager.getImageFromUrl(url: proOrder.imageUrl, imgView: self.professionalAvatarImgV, imgSize: 120)
        let str = "rating_img_\(proOrder.rating).png"
        professionalRatingImgV.image = UIImage(named: str)
    }
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onGetProButtonClick(_ sender: Any) {
        
        self.loadingAI.startAnimating()
        loadingAI.isHidden = false
        self.setViewState(isEnabled: false)
    
        let order = UserOrderView()
        order.categoryName = orderReq.categoryName
        order.orderRequstId = orderReq.id
        order.problemDescription = orderReq.problemDescription
        order.professionalId = proOrder.professionalId
        order.professionalImageUrl = proOrder.imageUrl
        order.professionalName = proOrder.name
        order.professionalRating = proOrder.rating
        order.userId = orderReq.userId
        order.userImageUrl = orderReq.userImageUrl
        order.userName = orderReq.userName
        OrdersManager.confirmOrderByUser(userOrder: order, view: self)
    
    }
    
    func onGetDataResponse(response: Response) {
        if response.status {
            loadingAI.stopAnimating()
            loadingAI.isHidden = true
            // move to top order confirmation controller
            self.performSegue(withIdentifier: "acceptTopProfessionalSeg", sender: self)
        }
        else {
            self.loadingAI.stopAnimating()
            self.loadingAI.isHidden = true
            self.setViewState(isEnabled: true)
            self.displayAlert( message: response.errorTxt)
        }
    }
    
    @IBAction func onMoreProfessionalCuttonClick(_ sender: Any) {
        // move to professionals controller
        self.performSegue(withIdentifier: "professionalSeg", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "professionalSeg" {
            let vc = segue.destination as! ProfessionalsViewController
            vc.declinedProfessionalId = self.proOrder.professionalId
            vc.orderRequestId = self.orderReq.id
        }
    }
    
    func setViewState(isEnabled:Bool){
        getProBtn.isEnabled = isEnabled
        moreProfessionalsBtn.isEnabled = isEnabled
        backBtn.isEnabled = isEnabled
    }
}
