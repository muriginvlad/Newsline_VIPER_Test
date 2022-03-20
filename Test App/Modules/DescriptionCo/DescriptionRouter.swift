//
//  DescriptionRouter.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import Foundation
import UIKit

class DescriptionRouter: DescriptionRouterProtocol {

    weak var viewController: DescriptionViewController!
    
    init(viewController: DescriptionViewController) {
        self.viewController = viewController
    }
    
    func dismiss() {
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
