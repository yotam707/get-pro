//
//  ProOrdersTabViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 29/08/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class ProOrdersTabViewController : BaseUIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ordersTV: UITableView!
    var orders = [ProfessionalOrderDetailsView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orders = OrdersManager.proOrders
        self.ordersTV.dataSource = self
        self.ordersTV.delegate = self
        self.setViewColor(view: self.view, color: K.Colors.darkGray)
        self.setViewColor(view: self.ordersTV, color: K.Colors.darkGray)
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
            withIdentifier: "proOrderCell",
            for: indexPath) as! ProfessionalOrderHistoryUITavleViewCell
        
        self.setViewColor(view: cell, color: K.Colors.darkGray)
        AppManager.getImageFromUrl(url: order.userImageUrl, imgView: cell.userAvatarImgV, imgSize: 80)
        cell.userNameLbl.text = order.userName
        cell.userCityLbl.text = order.userCity
        cell.orderDateLbl.text = order.completedDate.description
        
        // Returning the cell
        return cell
    }    
}
