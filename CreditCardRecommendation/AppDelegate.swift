//
//  AppDelegate.swift
//  CreditCardRecommendation
//
//  Created by 박형환 on 2022/01/20.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
       let db = Firestore.firestore()
        
        
      
        db.collection("user").getDocuments { snapshot,_ in
            guard snapshot?.isEmpty == true else {debugPrint("nothing"); return}
            
            let batch = db.batch()
            
            let ref0 = db.collection("user").document("card0")
            let ref1 = db.collection("user").document("card1")
            let ref2 = db.collection("user").document("card2")
            let ref3 = db.collection("user").document("card3")
            let ref4 = db.collection("user").document("card4")
            let ref5 = db.collection("user").document("card5")
            let ref6 = db.collection("user").document("card6")
            let ref7 = db.collection("user").document("card7")
            let ref8 = db.collection("user").document("card8")
            let ref9 = db.collection("user").document("card9")
            
            let cardDummyData = CreditCardDummy.self
            
            guard let data0 = cardDummyData.card0.convertToDict() else{ return}
            guard let data1 = cardDummyData.card1.convertToDict() else{ return}
            guard let data2 = cardDummyData.card2.convertToDict() else{ return}
            guard let data3 = cardDummyData.card3.convertToDict() else{ return}
            guard let data4 = cardDummyData.card4.convertToDict() else{ return}
            guard let data5 = cardDummyData.card5.convertToDict() else{ return}
            guard let data6 = cardDummyData.card6.convertToDict() else{ return}
            guard let data7 = cardDummyData.card7.convertToDict() else{ return}
            guard let data8 = cardDummyData.card8.convertToDict() else{ return}
            guard let data9 = cardDummyData.card9.convertToDict() else{ return}
            
            
            batch.setData(data0, forDocument: ref0)
            batch.setData(data1, forDocument: ref1)
            batch.setData(data2, forDocument: ref2)
            batch.setData(data3, forDocument: ref3)
            batch.setData(data4, forDocument: ref4)
            batch.setData(data5, forDocument: ref5)
            batch.setData(data6, forDocument: ref6)
            batch.setData(data7, forDocument: ref7)
            batch.setData(data8, forDocument: ref8)
            batch.setData(data9, forDocument: ref9)
                    
            
            batch.commit()
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available (iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available (iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

