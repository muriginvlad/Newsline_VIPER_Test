//
//  NewsModel.swift
//  Test App
//
//  Created by Vladislav on 16.03.2022.
//

import Foundation

class NewsModel: Equatable {
    let formatter = DateFormatter()
    
    let title: String
    let descriptionNews: String?
    let source: String
    let datePost: Date
    let urlToImage: String?
    var newsRead: Bool = false
   
    init(with data: Article) {
        self.title = data.title ?? "Новость"
        self.descriptionNews = data.description
        self.source = data.source?.name ?? "Неизвестный источник"

        if let publishedAt = data.publishedAt {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            self.datePost = formatter.date(from: publishedAt) ?? Date()
        } else {
            self.datePost = Date()
        }
        self.urlToImage = data.urlToImage
    }
    
    init(with data: MediaStackData) {
        self.title = data.title ?? "Новость"
        self.descriptionNews = data.description
        self.source = data.source ?? "Неизвестный источник"

        if let publishedAt = data.publishedAt {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            self.datePost = formatter.date(from: publishedAt) ?? Date()
        } else {
            self.datePost = Date()
        }
        
        self.urlToImage = data.image
    }
    
    init(with data: NewsModelCoreData) {
        self.title = data.title ?? "Новость"
        self.descriptionNews = data.descriptionNews
        self.source = data.source ?? "Неизвестный источник"
        self.datePost = data.datePost ?? Date()
        self.urlToImage = data.urlToImage
        self.newsRead = data.newsRead
    }
    
    static func == (lhs: NewsModel, rhs: NewsModel) -> Bool {
        return lhs.title == rhs.title
    }
    
}
