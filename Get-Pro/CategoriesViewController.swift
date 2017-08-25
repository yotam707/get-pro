//
//  CategoriesViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 06/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class CategoriesViewController: BaseUIViewController, UITableViewDelegate, UITableViewDataSource {
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
        categoriesTV.reloadData()
        //self.loadingAI.bringSubview(toFront: UIView)
           }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categories = AppManager.getCategories()
        self.categoriesTV.delegate = self
        self.categoriesTV.dataSource = self
 
        loadingAI.startAnimating()
        self.setViewState(isEnabled: false)

        self.problamDescTV.layer.borderColor = AppManager.getColor(colorKey: K.Colors.mediumRed) .cgColor
        self.problamDescTV.layer.borderWidth = 0.5
        //self.problamDescTV.layer.cornerRadius = 5

    
        //self.setViewColor(view: self.view, color: K.Colors.darkGray)
        self.setViewColor(view: horizontalLineV, color: K.Colors.lightRed)
        self.setViewColor(view: navigationBar, color: K.Colors.darkGray)
        self.setViewColor(view: categoriesTV, color: K.Colors.darkGray)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        
        //send request to server
        let orderRequest = OrderRequest()
        orderRequest.categoryId = selectedCell.category.id
        orderRequest.userId = AppManager.getUserId()
        orderRequest.problemDescription = problamDescTV.text
        orderRequest.requestDate = DispatchTime.now()
        AppManager.publishOrder(orderReq: orderRequest)
        
        
        //need to display here spinner\loader for up to 60 sec and lock the UI
        
        
        // move to top professional controller
        self.performSegue(withIdentifier: "topProfessionalSeg", sender: self)
    }*/
    
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

        //send request to server
        let orderRequest = OrderRequest()
        orderRequest.categoryId = self.categories[indexPath.row].id
        orderRequest.userId = AppManager.getUserId()
        orderRequest.problemDescription = problamDescTV.text
        orderRequest.requestDate = DispatchTime.now()
        AppManager.publishOrder(orderReq: orderRequest)
        
        
        //need to display here spinner\loader for up to 60 sec and lock the UI
        
        
        // move to top professional controller
        self.performSegue(withIdentifier: "topProfessionalSeg", sender: self)
        
        
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

    
}
