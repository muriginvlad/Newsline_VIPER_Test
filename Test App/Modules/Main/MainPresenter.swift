//
//  MainPresenter.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import Foundation
import UIKit

class MainPresenter: MainPresenterProtocol {

    weak var view: MainViewProtocol!
    var interactor: MainInteractorProtocol!
    
    var router: MainRouterProtocol!
    
    private var news: [NewsModel] = []
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        showSpiner()
        updateTableNews()
        interactor.showDescriptionsOnCell()
        interactor.downloadNews()
        
    }
    
    func markNews(title: String) {
        news = interactor.updateReadStatus(title: title)
        view?.dataUpdate(data: news)
    }
    
    func openNews(news: NewsModel) {
        router.showNews(news: news)
    }
    
    func openSettings() {
        router.showSettings()
    }
    
    func showDescriptions(show: Bool) {
        view?.showDescriptions(show: true)
    }
    
    func updateTableNews() {
        news = interactor.restoreNews()
        hideSpiner()
        view?.dataUpdate(data: news)
    }
    
    
    private func showSpiner() {
        view?.showSpiner()
    }
    
    private func hideSpiner() {
        view?.hideSpiner()
    }
    
    private func updateData() {

        
    }

}
