//
//  CardListViewController.swift
//  CreditCardRecommendation
//
//  Created by 박형환 on 2022/02/19.
//

import UIKit
import FirebaseDatabase
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class CardListViewController: UITableViewController {
 

    var cardListData: [String : CardData] = [:]
    var cardList: [CardData] = []
    var ref: DatabaseReference!
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let component = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(component, forCellReuseIdentifier: "CardCell")

//        firebaseGetData()
        self.getDataOnFireStore()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){ [weak self] in
            guard let self = self else {return}
           
            self.tableView.reloadData()
        }
        
    } //viewDidLoad
    
    //fireStore 에서 데이터 읽기
    fileprivate func getDataOnFireStore() {
    
        db.collection("user").getDocuments() { [weak self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let result = Result {
                        try document.data(as: CardData.self)
                    }
                    switch result {
                    case .success(let cardData):
                        if let cardData = cardData{
                            guard let self = self else {return}
                            self.cardList.append(cardData)
                        }else {
                            debugPrint("document does not exist")
                        }
                    case .failure(let error):
                        print("Error decoding cardData: \(error)")
                    } // switch
                } // quertSnapshot
                DispatchQueue.main.async {
                    guard let self = self else {return}
                    debugPrint("DispatchQueue - TableView reloadData")
                    self.tableView.reloadData()
                }
            } // err == nil
        } // getDocuments()
    }
    
    
    //Bundle.main.url 경로에서 json 파일 불러오기
    fileprivate func load() -> [String : CardData]? {
        let fileName: String = "credit-card-list"
        let extensionType: String = "json"
        guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: extensionType) else { return nil }
        do{
            let data = try Data(contentsOf: fileLocation)
            let cardData = try? JSONDecoder().decode([String : CardData].self, from: data)
            return cardData
        }catch{
            return nil
        }
    }
    //파이어베이스 realtimedataBase 이용
    fileprivate func firebaseGetData(){
        ref = Database.database().reference()
            ref.child("/").getData(completion:  { [weak self] error, snapshot in
              guard error == nil else {
                print(error!.localizedDescription)
                return;
              }
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: snapshot.value!)
                    let data = try JSONDecoder().decode([String : CardData].self, from: jsonData)
                    guard let self = self else {return}
                    self.cardList = data.values.sorted{$0.rank < $1.rank}
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }catch{
                    debugPrint("catch - nil")
                }
            });
    }
    fileprivate func changeSelectedData(_ id: Int){
        db.collection("user").document("card\(id)")
            .updateData(["isSelected" : true] ){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        } // db.collection.document
    }
    
    //Cell에 있는 버튼 클릭시
    @objc fileprivate func arrowButtonClicked(_ sender: ArrowButton) {
        debugPrint("arrowButtonClicked - called")
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        guard let index = sender.indexPath?.row else {return}
        vc.cardData = cardList[index]
        let id = cardList[index].id
        self.changeSelectedData(id)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        vc.cardData = cardList[indexPath.row]
        let id = cardList[indexPath.row].id
        self.changeSelectedData(id)
//        ref.child("Item\(id)/isSelected").setValue(true)
      
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as? CardCell else {return UITableViewCell() }
        cell.cardCellData = cardList[indexPath.row]
        cell.arrow.indexPath = indexPath
        cell.arrow.addTarget(self, action: #selector(arrowButtonClicked(_:)), for: .touchUpInside)
        return cell
    }
}

