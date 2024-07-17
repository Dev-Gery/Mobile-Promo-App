//
//  ViewController.swift
//  Mobile App Promo
//
//  Created by admin on 7/17/24.
//

import UIKit
import WebKit

class MainViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, PromoManagerDelegate {

    var promoMgr = PromoManager()
    var promoArray : [PromoModel]?
    @IBOutlet weak var PromoCollectionView: UICollectionView!
    var webViewController: UIViewController!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PromoCollectionView.dataSource = self
        PromoCollectionView.delegate = self
        PromoCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        promoMgr.delegate = self
        promoMgr.fetchPromo()
        
        webViewController = UIViewController()
        webView = WKWebView(frame: webViewController.view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webViewController.view.addSubview(webView)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promoArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainCollectionViewCell
        cell.TitleLabel.text = promoArray?[indexPath.row].name
        cell.ImageView.image = promoArray?[indexPath.row].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width)
        return CGSize(width: size, height: size)
    }
    
    func didGetPromoData(_ promoData: [PromoModel]) {
        promoArray = promoData
        PromoCollectionView.reloadData()
    }
    
    func didGetPromoImage(_ promoImage: UIImage, forIndex index: Int) {
        promoArray?[index].image = promoImage
        PromoCollectionView.reloadData()
    }
    
    func didFailWithError(_ error: any Error) {
        print(error)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let urlString = promoArray?[indexPath.row].detail else { return }
        if let webUrl = URL(string: urlString) {
            let request = URLRequest(url: webUrl)
            webView.load(request)
        }
        webViewController.modalPresentationStyle = .pageSheet
        self.present(webViewController, animated: true, completion: nil)
    }
    
}

