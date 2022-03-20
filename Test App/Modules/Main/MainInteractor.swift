//
//  MainInteractor.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import Foundation

class MainInteractor: MainInteractorProtocol {
    
    weak var presenter: MainPresenterProtocol!
    
    let serverService: NetworkServiceProtocol = NetworkService()
    let storageService: StorageServiceProtocol = StorageService()
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    func downloadNews() {
        serverService.getMediaStackApiData {  [weak self] (data, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let dataResponse = data?.data {
                let news = dataResponse.map { NewsModel.init(with: $0) }
                _ = news.map{ self?.saveNews(data: $0) }
                self?.presenter.updateTableNews()
            }
        }
        
        
        serverService.getNewsApiData { [weak self] (data, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let dataResponse = data?.articles {
                let news = dataResponse.map { NewsModel.init(with: $0) }
                _ = news.map{ self?.saveNews(data: $0) }
                self?.presenter.updateTableNews()
            }
        }
    }
    
    func saveNews(data: NewsModel){
        self.storageService.savedNews(data: data)
    }
    
    func updateReadStatus(title: String) -> [NewsModel] {
        return self.storageService.updateReadStatus(title: title)
    }
    
    func restoreNews() -> [NewsModel] {
        return self.storageService.getSavedNews()
    }
    
    func showDescriptionsOnCell() {
        self.presenter.showDescriptions(show: self.storageService.detailedNews)
    }
    
}
