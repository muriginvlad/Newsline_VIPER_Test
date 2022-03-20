//
//  SettingsInteractor.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import Foundation

class SettingsInteractor: SettingsInteractorProtocol {
    
    weak var presenter: SettingsPresenterProtocol!
    
    let serverService: NetworkServiceProtocol = NetworkService()
    let storageService: StorageServiceProtocol = StorageService()
    
    required init(presenter: SettingsPresenterProtocol) {
        self.presenter = presenter
    }
    
    func updateSettings(news: [String], showDetail: Bool) {
    
    }
    
    func getNewsSourse() -> [String] {
        return []
    }
    
    func getShowDetailState() -> Bool {
        return false
    }
    
}
