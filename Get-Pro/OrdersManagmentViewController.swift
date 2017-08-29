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
        
        self.userOrdersTV.delegate = self
        self.userOrdersTV.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Getting the right element
        //let pro = userOrders[indexPath.row]
        
        // Instantiate a cell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "professionalCell",
            for: indexPath) as! ProfessionalTableViewCell
        
        self.setViewColor(view: cell, color: K.Colors.darkGray)
        
//        // Adding the right informations
//        cell.professional = pro
//        cell.acceptProfessionalClickDelegate = self
//        cell.professionalNameLbl.text = pro.name
        
        //let url = NSURL(string: pro.imageUrl) //postPhoto URL
        //let data = NSData(contentsOfURL: url! as URL ) // this URL convert into Data
        //if data != nil {  //Some time Data value will be nil so we need to validate such things
        // cell.avatarImageImgV.image = UIImage(data: data!)
        //}
        
        cell.avatarImageImgV.image = UIImage(named: "avatar.png")
        
        cell.avatarImageImgV.layer.cornerRadius = 40
        cell.avatarImageImgV.layer.borderColor = UIColor.white.cgColor
        cell.avatarImageImgV.layer.borderWidth = 3
        
        // Returning the cell
        return cell
    }
    
    
}
