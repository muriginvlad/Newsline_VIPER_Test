//
//  NewsModelCoreData+CoreDataProperties.swift
//  Test App
//
//  Created by Vladislav on 16.03.2022.
//
//

import Foundation
import CoreData


extension NewsModelCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsModelCoreData> {
        return NSFetchRequest<NewsModelCoreData>(entityName: "NewsModelCoreData")
    }

    @NSManaged public var urlToImage: String?
    @NSManaged public var descriptionNews: String?
    @NSManaged public var source: String?
    @NSManaged public var datePost: Date?
    @NSManaged public var newsRead: Bool
    @NSManaged public var title: String?

}

extension NewsModelCoreData : Identifiable {
}
