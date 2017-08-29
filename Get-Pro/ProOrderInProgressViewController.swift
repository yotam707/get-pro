//
//  ProOrderInProgressViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 29/08/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class ProOrderInProgressViewController : BaseUIViewController{
    
    @IBOutlet weak var orderDoneBtn: UIButton!
    @IBOutlet weak var orderTimerLbl: UILabel!
    var orderDetails = ProfessionalOrderDetailsView()
 

    
    @IBAction func onDoneButtonClick(_ sender: Any) {
        //send data to server
        OrdersManager.updateFinishOrder(orderReqId: orderDetails.orderRequestId, proId: orderDetails.professionalId, userId: orderDetails.userId)
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewColor(view: self.view, color:  K.Colors.darkGray)
        self.setViewColor(view: orderDoneBtn, color: K.Colors.darkGray)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
