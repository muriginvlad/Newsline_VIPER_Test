//
//  DescriptionConfigurator.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import Foundation
import UIKit

class DescriptionConfigurator: DescriptionConfiguratorProtocol {
    
    func configure(with viewController: DescriptionViewController) {
        let presenter = DescriptionPresenter(view: viewController)
        let interactor = DescriptionInteractor(presenter: presenter)
        let router = DescriptionRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
