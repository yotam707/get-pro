//
//  Protocols.swift
//  Get-Pro
//
//  Created by Eliran Levy on 09/07/2017.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import Foundation
import UIKit

protocol AcceptUserDelegate: class {
    func onUserAcceptBtnClick(orderRequest: OrderRequest, professional:Professional)
}

protocol AcceptProfessionalDelegate: class {
    func onProfessionalAcceptBtnClick(orderDetails: ProfessionalOrderDetailsView)
}

protocol GetDataProtocol: class {
    func onGetDataResponse(response:Response)
}

