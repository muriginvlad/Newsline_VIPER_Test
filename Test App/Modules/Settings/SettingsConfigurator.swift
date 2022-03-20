//
//  SettingsConfigurator.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import Foundation
import UIKit

class SettingsConfigurator: SettingsConfiguratorProtocol {
    
    func configure(with viewController: SettingsViewController) {
        let presenter = SettingsPresenter(view: viewController)
        let interactor = SettingsInteractor(presenter: presenter)
        let router = SettingsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
