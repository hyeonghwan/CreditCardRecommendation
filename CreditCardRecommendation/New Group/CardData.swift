//
//  CardData.swift
//  CreditCardRecommendation
//
//  Created by 박형환 on 2022/02/19.
//

import Foundation

struct CardData: Convertable{
    var id: Int
    var rank: Int
    var name: String
    var cardImageURL: String
    var promotionDetail: PromotionDetail
    var isSelected: Bool?
    
    
    // struct를 Dictionary로 변환 해주는 변수
    var asDictionary : [String:Any] {
       let mirror = Mirror(reflecting: self)
       let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
         guard let label = label else { return nil }
         return (label, value)
       }).compactMap { $0 })
       return dict
     }
    
}
struct PromotionDetail: Codable{
    var companyName: String
    var period: String
    var amount: Int
    var condition: String
    var benefitCondition: String
    var benefitDetail: String
    var benefitDate: String
}

