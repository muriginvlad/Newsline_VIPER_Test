//
//  MainRouter.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import Foundation
import UIKit

class MainRouter: MainRouterProtocol {

    weak var viewController: MainViewController!
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func showSettings() {
        let settingsViewController = SettingsViewController()
        viewController.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    func showNews(news: NewsModel) {
        let settingsViewController = DescriptionViewController(news: news)
        viewController.present(settingsViewController, animated: true, completion: nil)
    }

}
