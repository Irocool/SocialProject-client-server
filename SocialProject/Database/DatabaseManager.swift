//
//  DatabaseManager.swift
//  SocialProject
//
//  Created by Irina Kuligina on 05.12.2021.
//
import RealmSwift

class DatabaseManager {
    static var shared = DatabaseManager()
    let realm = try! Realm()

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
    
    func saveImageData(images: [Image]) {
        try? realm.write {
            realm.add(images, update: .modified)
        }
    }
    
    // MARK: - Loading data
    
    func loadGroupData() -> Results<Group> {
        return realm.objects(Group.self)
    }
    
    func loadUserData() -> Results<User> {
        return realm.objects(User.self)
    }
    
    func loadImageDataBy(ownerID: Int) -> Results<Image> {
        return realm.objects(Image.self).filter("ownerID == %@", ownerID).sorted(byKeyPath: "date", ascending: false)
    }

    // MARK: - Remove all data
    
    func deleteGroupData() {
        let result = realm.objects(Group.self)
        try? realm.write {
            realm.delete(result)
        }
    }
    
    func deleteUserData() {
        let result = realm.objects(User.self)
        try? realm.write {
            realm.delete(result)
        }
    }
    
    func deleteImageData() {
        let result = realm.objects(Image.self)
        try? realm.write {
            realm.delete(result)
        }
    }
}

