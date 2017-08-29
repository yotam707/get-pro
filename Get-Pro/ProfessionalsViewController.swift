//
//  ProfessionalsViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 06/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class ProfessionalsViewController: BaseUIViewController, UITableViewDataSource, UITableViewDelegate, AcceptUserDelegate {
    
    
    @IBOutlet weak var professionalsTV: UITableView!
    var professionals = [Professional]()
    var orderRequestId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.professionalsTV.dataSource = self
        self.professionalsTV.delegate = self
        //self.professionals = AppManager.getProfessionals(orderRequestId: self.orderRequestId)
        self.setViewColor(view: self.view, color: K.Colors.darkGray)
        self.setViewColor(view: self.professionalsTV, color: K.Colors.darkGray)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return professionals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Getting the right element
        let pro = professionals[indexPath.row]
        
        // Instantiate a cell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "professionalCell",
            for: indexPath) as! ProfessionalTableViewCell
        
        self.setViewColor(view: cell, color: K.Colors.darkGray)
        
        // Adding the right informations
        cell.professional = pro
        cell.acceptClickDelegate = self
        cell.professionalNameLbl.text = pro.name
        cell.avatarImageImgV.image = UIImage(named: "avatar.png")
        cell.avatarImageImgV.layer.cornerRadius = 40
        cell.avatarImageImgV.layer.borderColor = UIColor.white.cgColor
        cell.avatarImageImgV.layer.borderWidth = 3
        let str = "rating_img_\(pro.rating).png"
        cell.ratingImgV.image = UIImage(named: str)
        
        // Returning the cell
        return cell
    }
    
    func onUserAcceptBtnClick(orderRequest: OrderRequest) {
        
        //send data to server
        //orderma
        
        
        // move to top order confirmation controller
        self.performSegue(withIdentifier: "acceptProfessionalSeg", sender: self)
    }
    
}
