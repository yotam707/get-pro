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
    @IBOutlet weak var loadingAI: UIActivityIndicatorView!
    
    var orders = [ProfessionalOrderDetailsView]()
    var orderDetails = ProfessionalOrderDetailsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingAI.bringSubview(toFront: ordersTV)
        self.loadingAI.stopAnimating()
        self.loadingAI.isHidden = true
        self.setViewColor(view: self.view, color: K.Colors.darkGray)
        self.setViewColor(view: self.ordersTV, color: K.Colors.darkGray)
        self.ordersTV.dataSource = self
        self.ordersTV.delegate = self
        self.setViewColor(view: self.ordersTV, color: K.Colors.darkGray)
        self.orders = OrdersManager.proPendingOrders
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        AppManager.getImageFromUrl(url: order.userImageUrl, imgView: cell.userAvatarImgV, imgSize: 80)
        cell.userNameLbl.text = order.userName
        cell.userCityLbl.text = order.userCity
        cell.proOrderDetails = order
        cell.acceptClickDelegate = self
        
        // Returning the cell
        return cell
    }
    
    func onGetDataResponse(response: Response) {
        if response.status {
            self.loadingAI.stopAnimating()
            self.loadingAI.isHidden = true
            // move to order confirmation controller
            DispatchQueue.main.async ( execute:{
                self.performSegue(withIdentifier: "proInProgressOrderListSeg", sender: self)
            })
        }
        else {
            loadingAI.stopAnimating()
            loadingAI.isHidden = true
            self.displayAlert(message: response.errorTxt)
        }
    }
    
    
    func onProfessionalAcceptBtnClick(orderDetails: ProfessionalOrderDetailsView) {
        //send data to server
        self.loadingAI.startAnimating()
        self.loadingAI.isHidden = false
        self.orderDetails = orderDetails
        OrdersManager.confirmOrderByProfessional(orderProDetails: orderDetails, view: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ProOrderInProgressViewController
        vc.orderDetails = self.orderDetails
    }
    
}
