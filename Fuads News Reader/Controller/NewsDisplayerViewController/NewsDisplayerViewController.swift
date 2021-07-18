//
//  NewsDisplayerViewController.swift
//  Fuads News Reader
//
//  Created by FA on 18/07/2021.
//

import UIKit

fileprivate let newsDisplayViewCellID = "NewsDisplayViewCell"

class NewsDisplayerViewController: UIViewController {
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    var newsArticle: News? = nil
    
    @IBAction func dismissButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if newsArticle == nil {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        self.configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.resizeImageView()
        self.loadImage()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - CollectionView Ext.
extension NewsDisplayerViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func configureCollectionView() {
        let cellNib = UINib(nibName: newsDisplayViewCellID, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: newsDisplayViewCellID)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newsDisplayViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: newsDisplayViewCellID, for: indexPath) as! NewsDisplayViewCell
        
        if let article = self.newsArticle {
            newsDisplayViewCell.configure(article)
        }
        
        return newsDisplayViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

// MARK: - Image Display loader
extension NewsDisplayerViewController {
    func loadImage() {
        guard let news = newsArticle else {
            return
        }
        
        if let imageURLString = news.urlToImage, let imageURL = URL(string: imageURLString) {
            self.articleImageView.loadImage(at: imageURL)
        }
    }
    
    func resizeImageView() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        DispatchQueue.main.async {
            self.imageViewHeightConstraint.constant = screenHeight / 3 
        }
    }
}
