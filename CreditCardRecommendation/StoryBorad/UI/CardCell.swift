//
//  CardCell.swift
//  CreditCardRecommendation
//
//  Created by 박형환 on 2022/02/19.
//

import UIKit
import Kingfisher
class CardCell: UITableViewCell{
    
    @IBOutlet weak var cardImage: UIImageView!
    
    @IBOutlet weak var rank: UILabel!
    
    @IBOutlet weak var benefitDetail: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var arrow: ArrowButton!
    
    var cardCellData: CardData? = nil {
        didSet {
            guard let data = cardCellData else {
                debugPrint("cardCellData - 실패")
                return}
            guard let url = URL(string: data.cardImageURL) else {return}
            debugPrint("ImageURL - \(url)")
            self.cardImage.kf.setImage(with: url)
            self.rank.text = "\(data.rank)위"
            self.benefitDetail.text = "\(data.promotionDetail.benefitDetail)"
            self.name.text = "\(data.name)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        debugPrint("CardCell - awakeFromNib - Called")
        self.arrow.tintColor = UIColor.black
        
    }
    
    
}
