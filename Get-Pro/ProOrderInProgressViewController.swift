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
    var timer: Timer?
    var counter = 0
    
    @IBAction func onDoneButtonClick(_ sender: Any) {
        //send data to server
        OrdersManager.updateFinishOrder(orderReqId: orderDetails.orderRequestId, proId: orderDetails.professionalId, userId: orderDetails.userId)
        
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewColor(view: self.view, color:  K.Colors.darkGray)
        self.setViewColor(view: orderDoneBtn, color: K.Colors.darkRed)
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimerUpdate), userInfo: nil, repeats: true)

    }
    
    func onTimerUpdate() {
        counter+=1
        let hh = (counter/3600)%24
        let preH = hh < 9 ? "0" : ""
        let mm = (counter/60)%60
        let preM = mm < 9 ? "0" : ""
        let ss = (counter%60)
        let preS = ss < 9 ? "0" : ""

        orderTimerLbl.text = "\(preH)\(hh):\(preM)\(mm):\(preS)\(ss)"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
