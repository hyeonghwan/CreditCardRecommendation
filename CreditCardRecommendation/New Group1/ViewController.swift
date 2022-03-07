//
//  ViewController.swift
//  CreditCardRecommendation
//
//  Created by 박형환 on 2022/01/20.
//

import UIKit
import SwiftUI
import Lottie
import FirebaseDatabase
import FirebaseFirestore

class ViewController: UIViewController {

    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var benefitCondition: UILabel!
    @IBOutlet weak var benefitDetail: UILabel!
    @IBOutlet weak var benefitDate: UILabel!
    
    @IBOutlet weak var animationView: AnimationView!
    var cardData: CardData?
    var ref: DatabaseReference!
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        labelTextConfiguration()
        let lottieView = AnimationView(name: "money")
        animationView.addSubview(lottieView)
        lottieView.frame = animationView.bounds
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        lottieView.play(completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let cardData = cardData else {return}
//        ref.child("Item\(cardData.id)/isSelected").setValue(nil)
        db.collection("user").document("card\(cardData.id)")
            .updateData(["isSelected" : false], completion: { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            })
        debugPrint("viewDidDisappear - called")
    }
    
    fileprivate func labelTextConfiguration() {
        period.text = cardData?.promotionDetail.period
        condition.text = cardData?.promotionDetail.condition
        benefitDetail.text = cardData?.promotionDetail.benefitDetail
        benefitCondition.text = cardData?.promotionDetail.benefitCondition
        benefitDate.text = cardData?.promotionDetail.benefitDate
    }
    

}
#if canImport(SwiftUI) && DEBUG
@available(iOS 13, *)
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    func makeUIViewController(context: Context) -> UIViewController {
        ViewController()
    }
    struct ViewController_Previews: PreviewProvider {
        static var previews: some View{
            ViewControllerRepresentable()
        }
    }
}
#endif

