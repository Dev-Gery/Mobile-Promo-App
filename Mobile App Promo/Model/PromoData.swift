//
//  PromoData.swift
//  Mobile App Promo
//
//  Created by admin on 7/17/24.
//

import UIKit

struct PromoData: Decodable {
    let promos: [Promo]
}

struct Promo: Decodable {
    let id: Int, name: String, images_url: String, detail: String
}
