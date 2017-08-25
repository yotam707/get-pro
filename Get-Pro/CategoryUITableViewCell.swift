//
//  CategoryUITableViewCell.swift
//  Get-Pro
//
//  Created by Eliran Levy on 24/08/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class CategoryUITableViewCell : UITableViewCell {
    
    @IBOutlet weak var cellBGV: UIView!
    @IBOutlet weak var categoryNameLbl: UILabel!
    weak var category = Category()
    
}
