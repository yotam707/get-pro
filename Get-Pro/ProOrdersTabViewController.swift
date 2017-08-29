//
//  ProOrdersTabViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 29/08/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class ProOrdersTabViewController : BaseUIViewController, UITableViewDelegate, UITableViewDataSource , GetDataProtocol {
    
    @IBOutlet weak var ordersTV: UITableView!
    var orders = [ProfessionalOrderDetailsView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orders = OrdersManager.proOrders
        self.setViewColor(view: self.view, color: K.Colors.darkGray)
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
            withIdentifier: "proOrderCell",
            for: indexPath) as! ProfessionalOrderHistoryUITavleViewCell
        
        self.setViewColor(view: cell, color: K.Colors.darkGray)
        
        cell.userAvatarImgV.image = UIImage(named: "avatar.png")
        cell.userAvatarImgV.layer.cornerRadius = 40
        cell.userAvatarImgV.layer.borderColor = UIColor.white.cgColor
        cell.userAvatarImgV.layer.borderWidth = 3
        cell.userNameLbl.text = order.userName
        cell.userCityLbl.text = order.userCity
        cell.orderDateLbl.text = order.completedDate.description
        
        // Returning the cell
        return cell
    }
    
    func onGetDataResponse(response: Response) {
        
    }

    
}
