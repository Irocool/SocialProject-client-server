//
//  DatabaseManager.swift
//  SocialProject
//
//  Created by Irina Kuligina on 05.12.2021.
//
import RealmSwift

class DatabaseManager {
    static var shared = DatabaseManager()
    private var realm = try! Realm()

    private init() {  }
    
    // MARK: - Saving data
    
    func saveGroupData(groups: [Group]) {
        try? realm.write {
            realm.add(groups)
        }
    }
    
    func saveUserData(groups: [User]) {
        try? realm.write {
            realm.add(groups)
        }
    }
    
    // MARK: - Loading data
    
    func loadGroupData() -> [Group] {
        return Array(realm.objects(Group.self))
    }
    
    func loadUserData() -> [User] {
        return Array(realm.objects(User.self))
    }
}
