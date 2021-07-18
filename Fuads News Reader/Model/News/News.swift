//
//  News.swift
//  Fuads News Reader
//
//  Created by FA on 18/07/2021.
//

import Foundation

// MARK: - Articles
struct Articles: Codable {
    var articles: [News]
}


// MARK: - News Structure
struct News: Codable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
