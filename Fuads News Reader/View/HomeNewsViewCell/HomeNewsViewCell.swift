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
    
    var onReuse: () -> Void = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setUpImageView()
    }
    
    func setUpImageView() {
        self.newsImageView.layer.masksToBounds = true
        self.newsImageView.layer.cornerRadius = 8
        
        let greyColor = UIColor.gray.cgColor
        
        self.newsImageView.layer.borderColor = greyColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        onReuse()
        self.newsImageView.image = nil
        self.newsImageView.cancelImageLoad()
    }
    
    func configure(_ article: News) {
        self.newsTitle.text = article.title ?? "Title not found"
        self.newsDescription.text = article.content ?? "Description not found"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        
        if let dateFromPublished = article.publishedAt, let timeAgoText = dateFormatter.date(from: dateFromPublished) {
            self.newsDateLabel.text = timeAgoText.timeAgoDisplay()
        } else {
            self.newsDateLabel.text = ""
        }
    }
    
}
