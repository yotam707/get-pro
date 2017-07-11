//
//  CategoriesViewController.swift
//  Get-Pro
//
//  Created by Eliran Levy on 06/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class CategoriesViewController: BaseUIViewController , UICollectionViewDataSource, UICollectionViewDelegate{
    @IBOutlet weak var problamDescTV: UITextView!
    @IBOutlet weak var categoriesCV: UICollectionView!
    @IBOutlet var navigationBar: UINavigationBar!
    var catergories = [Category]()
    
    @IBOutlet var horizontalLineV: UIView!
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoriesCV.dataSource = self
        self.categoriesCV.delegate = self
        self.catergories = AppManager.getCategories()
        
        self.problamDescTV.layer.borderColor = AppManager.getColor(colorKey: K.Colors.mediumRed) .cgColor
        self.problamDescTV.layer.borderWidth = 0.5
        self.problamDescTV.layer.cornerRadius = 5

    
        self.setViewColor(view: self.view, color: K.Colors.darkGray)
        self.setViewColor(view: horizontalLineV, color: K.Colors.lightRed)
        self.setViewColor(view: navigationBar, color: K.Colors.darkGray)
        self.setViewColor(view: categoriesCV, color: K.Colors.darkGray)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //rows
        let rows = Int(ceil(Float(catergories.count/2) + 0.1))
        return rows
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //columns
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        self.setViewColor(view: cell.categoryTV, color: K.Colors.darkRed)
        if self.catergories.count > 0 {
            let category = self.catergories.removeFirst();
            cell.category = category
            cell.categoryTV.text = category.name
            cell.categoryTV.textAlignment = .center

        }
        else {
            //hide the last cell in case we need
            cell.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        
        //send request to server
        let orderRequest = OrderRequest()
        orderRequest.categoryId = selectedCell.category.id
        orderRequest.userId = AppManager.getUserId()
        orderRequest.problemDescription = problamDescTV.text
        orderRequest.requestDate = DispatchTime.now()
        AppManager.publishOrder(orderReq: orderRequest)
        
        
        //need to display here spinner\loader for up to 60 sec and lock the UI
        
        
        // move to professionals controller
        self.performSegue(withIdentifier: "professionalsSeg", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        //handle here Async - add the request id & move to next controller
        let professionalsVC = segue.destination as! ProfessionalsViewController
        professionalsVC.orderRequestId = "123"
    }

    
}
