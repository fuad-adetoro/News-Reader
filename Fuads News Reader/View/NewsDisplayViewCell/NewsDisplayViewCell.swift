//
//  NewsDisplayViewCell.swift
//  Fuads News Reader
//
//  Created by FA on 18/07/2021.
//

import UIKit

class NewsDisplayViewCell: UICollectionViewCell {
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var newsAuthorLabel: UILabel!
    @IBOutlet weak var newsContentTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ article: News) {
        self.newsTitleLabel.text =  article.title ?? "..."
        self.newsContentTextView.text = article.content ?? "... \n ...."
        
        let timeAgo = article.publishedAt?.stringToSocialDate() ?? "1m"
        
        if let author = article.author {
            self.newsAuthorLabel.text = "Written by \(author) \(timeAgo)"
        } else {
            self.newsAuthorLabel.text = "Written \(timeAgo)"
        }
    }
}
