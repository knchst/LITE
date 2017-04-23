//
//  ViewController.swift
//  LITE
//
//  Created by Kenichi Saito on 4/22/17.
//  Copyright © 2017 Kenichi Saito. All rights reserved.
//

import UIKit
import APIKit
import GlidingCollection
import Kingfisher
import NVActivityIndicatorView
import RealmSwift
import SafariServices

class ViewController: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var glidingCollection: GlidingCollection!
    fileprivate var collectionView: UICollectionView!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(
            ActivityData(type: .cubeTransition, color: .black, backgroundColor: .clear)
        )
        
        glidingCollection.backgroundColor = .white
        glidingCollection.collectionView.backgroundColor = .white
        
        getTopics()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    func setup() {
        glidingCollection.dataSource = self
        glidingCollection.delegate = self
        glidingCollection.collectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        glidingCollection.collectionView.delegate = self
        glidingCollection.collectionView.dataSource = self
    }
    
    func getTopics() {
        let request = TopicRequest()
        Session.send(request) { [weak self] result in
            switch result {
            case .success(_):
                self?.getTopicArticles()
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func getTopicArticles() {
        let topics = self.realm.objects(Topic.self)
        
        for (index, topic) in topics.enumerated() {
            let request = TopicArticleRequest(topicId: topic.meta?.destination)
            Session.send(request) { [weak self] result in
                switch result {
                case .success(_):
                    if index == topics.count - 1 {
                        self?.setup()
                        self?.glidingCollection.reloadData()
                        self?.glidingCollection.collectionView.reloadData()
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    }
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        }
    }
}

extension ViewController: GlidingCollectionDatasource, GlidingCollectionDelegate {
    func numberOfItems(in collection: GlidingCollection) -> Int {
        return self.realm.objects(Topic.self).count
    }
    
    func glidingCollection(_ collection: GlidingCollection, itemAtIndex index: Int) -> String {
        let topic = self.realm.objects(Topic.self)[index]
        return topic.title
    }
    
    func glidingCollection(_ collection: GlidingCollection, willExpandItemAt index: Int) { }
    
    func glidingCollection(_ collection: GlidingCollection, didExpandItemAt index: Int) { }
    
    func glidingCollection(_ collection: GlidingCollection, didSelectItemAt index: Int) { }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let topics = self.realm.objects(Topic.self)
        guard let meta = topics[glidingCollection.expandedItemIndex].meta else { return 0 }
        let articles = self.realm.objects(Article.self).filter("userId == %@", Int(meta.destination)!)
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        let topic = self.realm.objects(Topic.self)[glidingCollection.expandedItemIndex]
        guard let meta = topic.meta else { return UICollectionViewCell() }
        let articles = self.realm.objects(Article.self).filter("userId == %@", Int(meta.destination)!)
        let article = articles[indexPath.row]
        let url = URL(string: article.captionImageUrl)!
        
        cell.imageView.kf.setImage(with: url)
        cell.titleLabel.text = article.title
        cell.contentView.clipsToBounds = true
        cell.layer.shadowOffset = GlidingConfig.shared.cardShadowOffset
        cell.layer.shadowColor = GlidingConfig.shared.cardShadowColor.cgColor
        cell.layer.shadowOpacity = GlidingConfig.shared.cardShadowOpacity
        cell.layer.shadowRadius = GlidingConfig.shared.cardShadowRadius
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let topic = self.realm.objects(Topic.self)[glidingCollection.expandedItemIndex]
        guard let meta = topic.meta else { return }
        let articles = self.realm.objects(Article.self).filter("userId == %@", Int(meta.destination)!)
        let article = articles[indexPath.row]
        let url = URL(string: article.url + "?webview=true")!
        
        let vc = SFSafariViewController(url: url)
        vc.preferredControlTintColor = .black
        
        self.show(vc, sender: nil)
    }
}
