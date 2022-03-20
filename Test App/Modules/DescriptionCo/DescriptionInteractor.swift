//
//  DescriptionInteractor.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import Foundation

class DescriptionInteractor: DescriptionInteractorProtocol {
    
    weak var presenter: DescriptionPresenterProtocol!
    
    let serverService: NetworkServiceProtocol = NetworkService()
    let storageService: StorageServiceProtocol = StorageService()
    
    required init(presenter: DescriptionPresenterProtocol) {
        self.presenter = presenter
    }
    
}
