//
//  ProPendingOrdersTabViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 29/08/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class ProPendingOrdersTabViewController : BaseUIViewController, UITableViewDelegate, UITableViewDataSource , GetDataProtocol , AcceptProfessionalDelegate {
    @IBOutlet weak var ordersTV: UITableView!
    var orders = [ProfessionalOrderDetailsView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewColor(view: self.view, color: K.Colors.darkGray)
        self.orders = OrdersManager.proPendingOrders
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Getting the right element
        let order = orders[indexPath.row]
        
        // Instantiate a cell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "proPendingOrderCell",
            for: indexPath) as! ProfessionalOrderUITavleViewCell
        
        self.setViewColor(view: cell, color: K.Colors.darkGray)
        
        cell.userAvatarImgV.image = UIImage(named: "avatar.png")
        cell.userAvatarImgV.layer.cornerRadius = 40
        cell.userAvatarImgV.layer.borderColor = UIColor.white.cgColor
        cell.userAvatarImgV.layer.borderWidth = 3
        
        cell.userNameLbl.text = order.userName
        cell.userCityLbl.text = order.userCity
        cell.acceptClickDelegate = self
        
        // Returning the cell
        return cell
    }
    
    func onGetDataResponse(response: Response) {
        if response.status {
            // move to order confirmation controller
            self.performSegue(withIdentifier: "acceptProfessionalSeg", sender: self)
        }
        else {
            //alert
        }
    }
    
    
    func onProfessionalAcceptBtnClick(orderDetails: ProfessionalOrderDetailsView) {
        //send data to server
        OrdersManager.confirmOrderByProfessional(orderProDetails: orderDetails, view: self)
    }
    
}
