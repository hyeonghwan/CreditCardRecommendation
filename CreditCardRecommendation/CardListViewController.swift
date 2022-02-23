//
//  CardListViewController.swift
//  CreditCardRecommendation
//
//  Created by 박형환 on 2022/02/19.
//

import UIKit
import FirebaseDatabase

class CardListViewController: UITableViewController {

    var cardListData: [String : CardData] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let component = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(component, forCellReuseIdentifier: "CardCell")
       
//        guard let jsonData = load() else { return }
//        cardListData = jsonData
//        debugPrint(cardListData.keys)
        firebaseGetData()
       
        debugPrint("박형ㄴ환 : \(cardListData)")
       
    }
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
    fileprivate func firebaseGetData(){
        var ref: DatabaseReference!

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
                    self.cardListData = data
                    self.tableView.reloadData()
                }catch{
                    debugPrint("catch - nil")
                }
            });
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardListData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as? CardCell else {return UITableViewCell() }
        
        cell.cardCellData = cardListData["Item\(indexPath.row)"]

        
        
        return cell
    }
    
    
}
