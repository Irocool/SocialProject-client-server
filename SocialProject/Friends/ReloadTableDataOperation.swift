//
//  ReloadTableDataOperation.swift
//  SocialProject
//
//  Created by Irina Kuligina on 17.01.2022.
//

import Foundation
import RealmSwift

class ReloadTableDataOperation: Operation {
    var controller: FriendsTableViewController
    
    init(controller: FriendsTableViewController) {
        self.controller = controller
    }
    
    override func main() {
        guard let parseData = dependencies.first as? ParseUserDataOperation else { return }
        let realm = try! Realm()
        
        let result = realm.objects(User.self)
        try? realm.write {
            realm.delete(result)
        }
        
        try? realm.write {
            realm.add(parseData.outputData, update: .modified)
        }
    }
    
}
