//
//  PromoManager.swift
//  Mobile App Promo
//
//  Created by admin on 7/17/24.
//

import UIKit

struct PromoManager {
    var delegate: PromoManagerDelegate?
    
    func fetchPromo(withUrlString urlString: String = "https://demo5853970.mockable.io/promos") {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if error != nil {
                    DispatchQueue.main.async {
                        delegate?.didFailWithError(error!)
                    }
                }
                if data != nil {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(PromoData.self, from: data!)
                        print(decodedData)
                        let promoesWithoutFetchedImage: [PromoModel] = decodedData.promos.map{
                            { (promo: Promo) -> PromoModel in
                                PromoModel(id: promo.id, name: promo.name, detail: promo.detail, image: nil)
                            }($0)
                        }
                        DispatchQueue.main.sync {
                            delegate?.didGetPromoData(promoesWithoutFetchedImage)
                        }
                        for i in 0..<promoesWithoutFetchedImage.count {
                            fetchPromoImage(withUrl: decodedData.promos[i].images_url, forIndex: i)
                        }
                    } catch {
                        delegate?.didFailWithError(error)
                        return
                    }
                }
            })
            task.resume()
        }
    }
    
    private func fetchPromoImage(withUrl imageUrl: String, forIndex index: Int) {
        if let url = URL(string: imageUrl) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data, error == nil else {
                    print("Error fetching image: \(String(describing: error))")
                    return
                }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    delegate?.didGetPromoImage((image ?? UIImage(named: "BNI_WHS"))!, forIndex: index)
                }
            }
            task.resume()
        }
    }    
}
