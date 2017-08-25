//
//  Protocols.swift
//  Get-Pro
//
//  Created by Eliran Levy on 09/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation
import UIKit

protocol AcceptProfessionalDelegate: class {
    func onProfessionalAcceptBtnClick(potentialOrderRequestId: String)
}

protocol GetCategoriesDelegate: class {
    func onGetCategoriesResponse() -> [Category]
}
