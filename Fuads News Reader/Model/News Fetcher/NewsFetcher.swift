//
//  NewsFetcher.swift
//  Fuads News Reader
//
//  Created by FA on 18/07/2021.
//

import Foundation

fileprivate let newsApiURL = "https://newsapi.org"
fileprivate let newsAPIVersion = "v2"
fileprivate let apiKey = "b31a273fc3d140a28b574ae9d5ad4913"

// MARK: - News Fetcher
class NewsFetcher {
    static let shared = NewsFetcher.init()
    
    func fetchRandomNews(completion: @escaping (([News], Error?) -> Void)) {
        if let url = URL(string: "\(newsApiURL)/\(newsAPIVersion)/everything?q=tesla&from=2021-06-18&sortBy=publishedAt&apiKey=\(apiKey)") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  do {
                     let res = try JSONDecoder().decode(Articles.self, from: data)
                    let newsArticles = res.articles
                    completion(newsArticles, nil)
                  } catch let error {
                    completion([], error)
                  }
               }
           }.resume()
        }
    }
}
