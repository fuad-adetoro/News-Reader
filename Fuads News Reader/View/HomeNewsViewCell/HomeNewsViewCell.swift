//
//  HomeNewsViewCell.swift
//  Fuads News Reader
//
//  Created by FA on 18/07/2021.
//

import UIKit

class HomeNewsViewCell: UICollectionViewCell {
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ article: News) {
        self.newsTitle.text = article.title ?? "Title not found"
        self.newsDescription.text = article.description ?? "Description not found"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        
        if let dateFromPublished = article.publishedAt, let timeAgoText = dateFormatter.date(from: dateFromPublished) {
            self.newsDateLabel.text = timeAgoText.timeAgoDisplay()
        } else {
            self.newsDateLabel.text = ""
        }
    }
    
}
