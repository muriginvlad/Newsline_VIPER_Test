//
//  SettingsRouter.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import Foundation
import UIKit

class SettingsRouter: SettingsRouterProtocol {

    weak var viewController: SettingsViewController!
    
    init(viewController: SettingsViewController) {
        self.viewController = viewController
    }
    
    func dismiss() {
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
