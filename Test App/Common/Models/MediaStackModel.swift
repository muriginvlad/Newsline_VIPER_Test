//
//  MediaStackModel.swift
//  Test App
//
//  Created by Vladislav on 16.03.2022.
//

import Foundation

struct MediaStackModel: Decodable {
    let pagination: Pagination?
    let data: [MediaStackData]?
}


struct MediaStackData: Decodable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let source: String?
    let image: String?
    let category: String?
    let language: String?
    let country: String?
    let publishedAt: String?
}

struct Pagination: Decodable {
    let limit, offset, count, total: Int?
}

