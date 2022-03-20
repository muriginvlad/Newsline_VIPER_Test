//
//  SettingsPresenter.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import Foundation
import UIKit

class SettingsPresenter: SettingsPresenterProtocol {

    weak var view: SettingsViewProtocol!
    var interactor: SettingsInteractorProtocol!
    var router: SettingsRouterProtocol!
    private var showDetail: Bool = false
    private var newsSourse: [String] = [] 
    
    required init(view: SettingsViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        self.newsSourse = interactor.getNewsSourse()
        self.showDetail = interactor.getShowDetailState()
        view?.setup(news: self.newsSourse, showDetail: self.showDetail)
    }
    
    func updateSettings(news: [String], showDetail: Bool) {
        interactor.updateSettings(news: news, showDetail: showDetail)
        router.dismiss()
    }
}
