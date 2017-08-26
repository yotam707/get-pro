//
//  CategoriesViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 06/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class CategoriesViewController: BaseUIViewController, UITableViewDelegate, UITableViewDataSource , GetDataProtocol {
    
    @IBOutlet weak var problamDescTV: UITextView!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet weak var categoriesTV: UITableView!
    @IBOutlet var horizontalLineV: UIView!
    @IBOutlet weak var loadingAI: UIActivityIndicatorView!

    var categories = [Category]()
    
       
    @IBAction func onBackButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.categories = CategoriesManager.categories
        categoriesTV.reloadData()
        self.loadingAI.isHidden = true
        self.loadingAI.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.categories = AppManager.getCategories()
        self.categoriesTV.delegate = self
        self.categoriesTV.dataSource = self
        self.problamDescTV.layer.borderColor = AppManager.getColor(colorKey: K.Colors.mediumRed) .cgColor
        self.problamDescTV.layer.borderWidth = 0.5
        
        //self.setViewColor(view: self.view, color: K.Colors.darkGray)
        self.setViewColor(view: horizontalLineV, color: K.Colors.lightRed)
        self.setViewColor(view: navigationBar, color: K.Colors.darkGray)
        self.setViewColor(view: categoriesTV, color: K.Colors.darkGray)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = self.categoriesTV.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryUITableViewCell!
        
        let category = self.categories[indexPath.row]
        cell?.category = category
        cell?.categoryNameLbl.text = category.name
        self.setViewColor(view: (cell?.cellBGV)!, color: K.Colors.darkGray)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        //start animation + lock the view
        self.loadingAI.startAnimating()
        self.loadingAI.isHidden = false
        self.setViewState(isEnabled: false)
        
        //send request to server
        let orderRequest = OrderRequest()
        orderRequest.categoryId = self.categories[indexPath.row].id
        orderRequest.userId = AppManager.getUserId()
        orderRequest.problemDescription = problamDescTV.text
        orderRequest.requestDate = Date()
        
        // move to top professional controller
        //self.performSegue(withIdentifier: "topProfessionalSeg", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        //handle here Async - add the request id & move to next controller
        let professionalsVC = segue.destination as! TopProfessionalViewController
        professionalsVC.orderRequestId = "123"
    }
    
    func setViewState(isEnabled:Bool){
        self.categoriesTV.isScrollEnabled = isEnabled
        self.categoriesTV.allowsSelection = isEnabled
        self.problamDescTV.isUserInteractionEnabled = isEnabled
    }
    
    func onGetDataResponse(response: Response) {
        
        switch response.actionType {
        case K.ActionTypes.AcceptOrderRequest:
            break;
        default:
            //publish order requesr
            if response.status {
                //save the result locally
                self.performSegue(withIdentifier: "topProfessionalSeg", sender: self)
            }
            else {
                //alert
                self.loadingAI.stopAnimating()
                self.loadingAI.isHidden = true
                self.setViewState(isEnabled: true)
            }
           
        }
    }


    
}
