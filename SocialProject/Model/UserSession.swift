//
//  UserSession.swift
//  SocialProject
//
//  Created by Irina Kuligina on 17.11.2021.
//

import Foundation

// MARK: - Singleton Session
class UserSession {
    static let instance = UserSession()
    
    private init() {  }
    
    var token: String? = nil  // Токен VK
    var userID: Int? = nil    // Идентификатор пользователя VK
}
