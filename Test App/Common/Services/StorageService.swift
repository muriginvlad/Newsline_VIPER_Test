//
//  StorageService.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import Foundation
import CoreData
import UIKit

protocol StorageServiceProtocol: class {
    var subSorting: Int  { set get }
    var newsSource: [String]  { set get }
    var detailedNews: Bool  { set get }
    
    func savedNews(data: NewsModel)
    func updateReadStatus(title: String) -> [NewsModel]
    func getSavedNews() -> [NewsModel]
}

class StorageService: StorageServiceProtocol {
    
    private enum Keys {
        static let updateInterval = "updateInterval"
        static let newsSource = "newsSource"
        static let detailedNews = "detailedNews"
    }
    
  
    private let defaults: UserDefaults
    
    private var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
      }()
    
    
    var subSorting: Int {
        set { defaults.set(newValue, forKey: Keys.updateInterval) }
        get { defaults.integer(forKey: Keys.updateInterval) }
    }
    
    
    var newsSource: [String] {
        set { defaults.set(newValue, forKey: Keys.newsSource) }
        get { defaults.array(forKey: Keys.newsSource) as? [String] ?? []}
    }
    
    var detailedNews: Bool {
        set { defaults.set(newValue, forKey: Keys.detailedNews)}
        get { defaults.bool(forKey: Keys.detailedNews) }
    }
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        defaults.register(defaults: [
            Keys.updateInterval: 60,
            Keys.newsSource: [],
            Keys.detailedNews: false,
        ])
    }
    
    func getSavedNews() -> [NewsModel] {
        var allNews: [NewsModelCoreData] = []
        do { allNews  =  try context.fetch(NewsModelCoreData.fetchRequest()) } catch {}
        return allNews.map {NewsModel.init(with: $0)}
    }
    
    func savedNews(data: NewsModel) {
        var allNews: [NewsModelCoreData] = []
        do { allNews  =  try context.fetch(NewsModelCoreData.fetchRequest()) } catch {}
        
        if let news = (allNews.filter {$0.title == data.title}.first) {
            print(news)
           return
        }
        
        let newNews = NewsModelCoreData(context: context)
        newNews.urlToImage = data.urlToImage
        newNews.descriptionNews = data.descriptionNews
        newNews.source = data.source
        newNews.datePost = data.datePost
        newNews.newsRead = data.newsRead
        newNews.title = data.title
        
        saveContext()
    }
    
    func updateReadStatus(title: String) -> [NewsModel] {
        var allNews: [NewsModelCoreData] = []
        do { allNews = try context.fetch(NewsModelCoreData.fetchRequest()) } catch {}
       
        let news = allNews.first { $0.title == title }
                
        let status = news?.newsRead ?? false
        if !status {
            context.performAndWait {
                news?.setValue(!status, forKey: "newsRead")
                try? context.save()
            }
        }
        saveContext()
        return getSavedNews()
    }
 
    private func saveContext(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
    }
}
