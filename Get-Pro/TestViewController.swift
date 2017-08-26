//
//  TestViewController.swift
//  Get-Pro
//
//  Created by Yotam Bloom on 8/20/17.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    var reqIdVal: String = ""
    var reqDescVal: String = ""
    var reqLocationVal: String = ""

    @IBOutlet weak var reqId: UILabel!
    @IBOutlet weak var reqDesc: UILabel!
    @IBOutlet weak var reqLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //OrdersManager.confirmOrder(orderReqId: "-KsKKSKmt8nqGhUdQSqQ", professionalId: "jvriIZ20hXSktUGN31kiTn02Kwy1", userId: String)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    
   // func initView(){
//        OrdersManager.getProfessionalOrderDetails(orderId: reqIdVal, { (order) in
//            
//            DispatchQueue.main.async {
//                
//            }
//            print(order)
//            self.reqId.text = self.reqIdVal
//            self.reqDesc.text = order.problemDescription
//        })
//        }

   // }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


