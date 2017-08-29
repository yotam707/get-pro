//
//  OrdersManagmentViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 06/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class OrdersManagmentViewController: BaseUIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var userOrdersTV: UITableView!
    var userOrders = [UserOrderView]()
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userOrders = OrdersManager.userOrders
        self.userOrdersTV.delegate = self
        self.userOrdersTV.dataSource = self
        self.setViewColor(view: self.view, color: K.Colors.darkGray)
        self.setViewColor(view: self.userOrdersTV, color: K.Colors.darkGray)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Getting the right element
        let order = userOrders[indexPath.row]
        
        // Instantiate a cell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "userOrderCell",
            for: indexPath) as! UserOrdersUITableViewCell
        
        self.setViewColor(view: cell, color: K.Colors.darkGray)
        
        //cell.professionalAvatarImgV.image = UIImage(named: "avatar.png")
        AppManager.getImageFromUrl(url: order.professionalImageUrl, imgView: cell.professionalAvatarImgV)
        cell.professionalAvatarImgV.layer.cornerRadius = 35
        cell.professionalAvatarImgV.layer.borderColor = UIColor.white.cgColor
        cell.professionalAvatarImgV.layer.borderWidth = 3
        
        let str = ("rating_img_\(order.professionalRating).png")
        cell.professionalRatingImgV.image = UIImage(named: str)
        
        cell.professionalNameLbl.text = order.professionalName
        cell.categoryNameLbl.text = order.categoryName
        cell.orderDateLbl.text = OrdersManager.shortDateToString(date: order.completedDate)
        
        
        // Returning the cell
        return cell
    }
    
    
}
