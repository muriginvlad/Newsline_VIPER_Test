//
//  DescriptionPresenter.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import Foundation
import UIKit

class DescriptionPresenter: DescriptionPresenterProtocol {

    

    weak var view: DescriptionViewProtocol!
    var interactor: DescriptionInteractorProtocol!
    
    var router: DescriptionRouterProtocol!
    
    private var news: [NewsModel] = []
    
    required init(view: DescriptionViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        
    }

    func dismiss() {
        router.dismiss()
    }
    
}
