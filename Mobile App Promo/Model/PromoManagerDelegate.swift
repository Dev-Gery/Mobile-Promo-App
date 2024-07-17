//
//  PromoManagerDelegate.swift
//  Mobile App Promo
//
//  Created by admin on 7/17/24.
//

import UIKit

protocol PromoManagerDelegate {
    func didGetPromoData(_ promoData: [PromoModel] )
    func didGetPromoImage(_ promoImage: UIImage, forIndex index: Int)
    func didFailWithError(_ error: Error)
}
