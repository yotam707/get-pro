//
//  ProfessionalsViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 06/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class ProfessionalsViewController: BaseUIViewController, UITableViewDataSource, UITableViewDelegate, AcceptUserDelegate, GetDataProtocol {
    
    
    @IBOutlet weak var professionalsTV: UITableView!
    @IBOutlet weak var loadingAI: UIActivityIndicatorView!
    
    var proOrders = [ProfessionalOrder]()
    var orderRequest = OrderRequest()
    var orderRequestId:String = ""
    var declinedProfessionalId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.professionalsTV.dataSource = self
        self.professionalsTV.delegate = self
        self.setViewColor(view: self.view, color: K.Colors.darkGray)
        self.setViewColor(view: self.professionalsTV, color: K.Colors.darkGray)
        loadingAI.bringSubview(toFront: professionalsTV)
        //get all relevant pros in pending
        OrdersManager.getAdditionalProfessionals(declinedProfessionalId: declinedProfessionalId, orderRequestId: orderRequestId, view: self)
        loadingAI.startAnimating()
        loadingAI.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Getting the right element
        let pro = proOrders[indexPath.row]
        
        // Instantiate a cell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "professionalCell",
            for: indexPath) as! ProfessionalTableViewCell
        
        self.setViewColor(view: cell, color: K.Colors.darkGray)
        
        // Adding the right informations
        cell.professional = pro
        cell.orderRequest = self.orderRequest
        cell.acceptClickDelegate = self
        cell.professionalNameLbl.text = pro.name
        AppManager.getImageFromUrl(url: pro.imageUrl, imgView: cell.avatarImageImgV, imgSize: 80)
        let str = "rating_img_\(pro.rating).png"
        cell.ratingImgV.image = UIImage(named: str)
        
        // Returning the cell
        return cell
    }
    
    func onUserAcceptBtnClick(orderRequest: OrderRequest, professional:ProfessionalOrder) {
        
        let order = UserOrderView()
        order.categoryName = orderRequest.categoryName
        order.orderRequstId = orderRequest.id
        order.problemDescription = orderRequest.problemDescription
        order.professionalId = professional.professionalId
        order.professionalImageUrl = professional.imageUrl
        order.professionalName = professional.name
        order.professionalRating = professional.rating
        order.userId = orderRequest.userId
        order.userImageUrl = orderRequest.userImageUrl
        order.userName = orderRequest.userName
        loadingAI.startAnimating()
        loadingAI.isHidden = false
        OrdersManager.confirmOrderByUser(userOrder: order, view: self)
    }
    
    func onGetDataResponse(response: Response) {
        switch response.actionType {
        case K.ActionTypes.confirmOrderRequestByUser:
            if response.status {
                loadingAI.stopAnimating()
                loadingAI.isHidden = true
                
                // move to top order confirmation controller
                self.performSegue(withIdentifier: "acceptProfessionalSeg", sender: self)
            }
            else {
                loadingAI.stopAnimating()
                loadingAI.isHidden = true
                self.displayAlert(message: response.errorTxt)
            }
        default:
            //get pending pro list
            if response.status {
                loadingAI.stopAnimating()
                loadingAI.isHidden = true
                
                self.proOrders = response.entities as! [ProfessionalOrder]
                self.professionalsTV.reloadData()
            }
            else {
                self.displayAlert(message: response.errorTxt)
            }
        }
        
    }
    
    
}
