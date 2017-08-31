//
//  CategoriesViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 06/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class CategoriesViewController: BaseUIViewController, UITableViewDelegate, UITableViewDataSource , GetDataProtocol {
    
    @IBOutlet weak var backBtn: UIBarButtonItem!
    @IBOutlet weak var problamDescTV: UITextView!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet weak var categoriesTV: UITableView!
    @IBOutlet var horizontalLineV: UIView!
    @IBOutlet weak var loadingAI: UIActivityIndicatorView!

    var categories = [Category]()
    var proOrder = ProfessionalOrder()
    var orderRequest = OrderRequest()
    
    var proOrders = [ProfessionalOrder]()
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
        self.setViewColor(view: self.view, color: K.Colors.darkGray)
        self.setViewColor(view: navigationBar, color: K.Colors.darkGray)
        self.setViewColor(view: categoriesTV, color: K.Colors.darkGray)

        self.orderRequest = OrderRequest()
        self.proOrder = ProfessionalOrder()
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
        cell?.categoryNameLbl.textColor = AppManager.getColor(colorKey: K.Colors.darkRed)

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        if problamDescTV.text == "" {
            self.displayAlert(message: "Please fill in problem description.")
            categoriesTV.reloadData()
            return
        }
        
        
        //start animation + lock the view
        self.loadingAI.startAnimating()
        self.loadingAI.isHidden = false
        self.setViewState(isEnabled: false)
        
        //send request to server
        self.orderRequest.categoryId = self.categories[indexPath.row].id
        self.orderRequest.categoryName = self.categories[indexPath.row].name
        self.orderRequest.userId = AppManager.getUserId()
        self.orderRequest.userName = LocalStorageManager.readFromStorage(key: K.User.name)
        self.orderRequest.userImageUrl = LocalStorageManager.readFromStorage(key: K.User.imageUrl)
        self.orderRequest.problemDescription = problamDescTV.text
        self.orderRequest.requestDate = Date()
        
        AppManager.publishOrder(view: self, orderReq: self.orderRequest)
        self.initActionTimer(view: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        //handle here Async - add the request id & move to next controller
        let professionalsVC = segue.destination as! TopProfessionalViewController
        professionalsVC.proOrder = self.proOrder
        professionalsVC.proOrders = self.proOrders
        professionalsVC.orderReq = self.orderRequest
    }
    
    func setViewState(isEnabled:Bool){
        self.categoriesTV.isScrollEnabled = isEnabled
        self.categoriesTV.allowsSelection = isEnabled
        self.problamDescTV.isUserInteractionEnabled = isEnabled
        self.backBtn.isEnabled = isEnabled
    }
    
    func onGetDataResponse(response: Response) {
        switch response.actionType {
        case K.ActionTypes.rejectAction:
            self.loadingAI.stopAnimating()
            self.loadingAI.isHidden = true
            self.setViewState(isEnabled: true)
            self.displayAlert(message: response.errorTxt)
            break
        default:
            if response.status {
                //save the result locally
                self.proOrders = (response.entities as! [ProfessionalOrder])
                self.proOrder = self.proOrders[0]
                self.orderRequest.id = self.proOrder.orderRequestId
                setViewState(isEnabled: true)
                self.performSegue(withIdentifier: "topProfessionalSeg", sender: self)
            }
            else {
                self.loadingAI.stopAnimating()
                self.loadingAI.isHidden = true
                self.setViewState(isEnabled: true)
                self.displayAlert( message: response.errorTxt)
            }
        }

    }


    
}
