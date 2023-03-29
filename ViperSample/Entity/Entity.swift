//
//  Entity.swift
//  ViperSample
//
//  Created by Seungchul Lee on 2023/03/27.
//

import Foundation

struct CandyEntity {
    let title: String
    let description: String
    let price: Float
    let imageName: String
}

struct CandyViewModel {
    let title: String
    let description: String
    let price: String
    let imageName: String
}

struct ChocoViewModel {
    let title: String
    let description: String
    let price: String
    let imageName: String
}

struct TotalPriceViewModel {
    let totalPrice: String
    let totalInclTax: String
    let vat: String
    let quantity: String
}
