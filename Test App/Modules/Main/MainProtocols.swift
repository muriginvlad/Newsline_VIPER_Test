//
//  MainProtocols.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import Foundation
import UIKit

protocol MainViewProtocol: class {
    func showSpiner()
    func hideSpiner()
    func dataUpdate(data: [NewsModel])
    func showDescriptions(show: Bool)
}

protocol MainPresenterProtocol: class {
    var router: MainRouterProtocol! { set get }
    func configureView()
    func updateTableNews()
    func showDescriptions(show: Bool)
    func markNews(title: String)
    func openNews(news: NewsModel)
    func openSettings()
}

protocol MainInteractorProtocol: class {
    func downloadNews()
    func restoreNews() -> [NewsModel]
    func saveNews(data: NewsModel)
    func updateReadStatus(title: String) -> [NewsModel]
    func showDescriptionsOnCell()
}

protocol MainRouterProtocol: class {
    func showSettings()
    func showNews(news: NewsModel)
}

protocol MainConfiguratorProtocol: class {
    func configure(with viewController: MainViewController)
}
