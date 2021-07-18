//
//  ViewController.swift
//  Fuads News Reader
//
//  Created by FA on 18/07/2021.
//

import UIKit

fileprivate let homeNewsViewCellID = "HomeNewsViewCell"

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var newsArticles: [News] = []
    var errorRetrievingArticles = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureCollectionView()
        self.fetchRandomNews()
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func configureCollectionView() {
        let cellNib = UINib(nibName: homeNewsViewCellID, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: homeNewsViewCellID)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if errorRetrievingArticles {
            return 1
        } else {
            return newsArticles.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if errorRetrievingArticles {
            return UICollectionViewCell.init()
        } else {
            let homeNewsViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: homeNewsViewCellID, for: indexPath) as! HomeNewsViewCell
            
            let article = self.newsArticles[indexPath.row]
            homeNewsViewCell.configure(article)
            
            if let imageURLString = article.urlToImage, let imageURL = URL(string: imageURLString) {
                homeNewsViewCell.newsImageView.loadImage(at: imageURL)
            }
            
            return homeNewsViewCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if errorRetrievingArticles {
            return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        } else {
            return CGSize(width: self.collectionView.frame.width, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !errorRetrievingArticles {
            // displayNewsDisplayerVC
            let article = self.newsArticles[indexPath.row]
            performSegue(withIdentifier: "displayNewsDisplayerVC", sender: article)
        }
    }
}

// MARK: - News Fetcher
extension HomeViewController {
    func fetchRandomNews() {
        NewsFetcher.shared.fetchRandomNews { [weak self] (news, error) in
            guard let strongSelf = self, error == nil else {
                self?.errorRetrievingArticles = true 
                return
            }
            
            strongSelf.errorRetrievingArticles = false
            strongSelf.newsArticles = news
            
            DispatchQueue.main.async {
                strongSelf.collectionView.reloadData()
            }
            
            print("NEWS COUNT: \(strongSelf.newsArticles.count)")
        }
    }
}

// MARK: - Passing Data with segue
extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        if identifier == "displayNewsDisplayerVC", let article = sender as? News {
            let newsDisplayerViewController = segue.destination as! NewsDisplayerViewController
            newsDisplayerViewController.newsArticle = article
        }
    }
}
