//
//  SettingsProtocols.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import Foundation
import UIKit

protocol SettingsViewProtocol: class {
    func setup(news: [String], showDetail: Bool )
}

protocol SettingsPresenterProtocol: class {
    var router: SettingsRouterProtocol! { set get }
    func configureView()
    func updateSettings(news: [String], showDetail: Bool )
}

protocol SettingsInteractorProtocol: class {
    func updateSettings(news: [String], showDetail: Bool )
    func getNewsSourse()-> [String]
    func getShowDetailState() -> Bool
}

protocol SettingsRouterProtocol: class {
    func dismiss()
}

protocol SettingsConfiguratorProtocol: class {
    func configure(with viewController: SettingsViewController)
}
