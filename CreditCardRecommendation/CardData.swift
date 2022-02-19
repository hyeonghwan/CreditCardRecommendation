//
//  CardData.swift
//  CreditCardRecommendation
//
//  Created by 박형환 on 2022/02/19.
//

import Foundation

struct CardData: Codable{
    var cardImageURL: String
    var id: Int
    var rank: Int
    var name: String
    var promotionDetail: PromotionDetail
}
struct PromotionDetail: Codable{
    var companyName: String
    var amount: Int
    var period: String
    var benefitDate: String
    var benefitDetail: String
    var benefitCondition: String
    var condition: String
}

