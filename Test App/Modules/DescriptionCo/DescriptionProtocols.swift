//
//  DescriptionProtocols.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import Foundation
import UIKit

protocol DescriptionViewProtocol: class {
}

protocol DescriptionPresenterProtocol: class {
    var router: DescriptionRouterProtocol! { set get }
    func configureView()
    func dismiss()
}

protocol DescriptionInteractorProtocol: class {

}

protocol DescriptionRouterProtocol: class {
    func dismiss()
}

protocol DescriptionConfiguratorProtocol: class {
    func configure(with viewController: DescriptionViewController)
}
