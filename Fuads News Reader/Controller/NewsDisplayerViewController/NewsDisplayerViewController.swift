//
//  NewsDisplayerViewController.swift
//  Fuads News Reader
//
//  Created by FA on 18/07/2021.
//

import UIKit

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
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
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
            self.imageViewHeightConstraint.constant = screenHeight / 3 - 60
        }
    }
}
