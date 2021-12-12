//
//  AlamofireSession.swift
//  SocialProject
//
//  Created by Irina Kuligina on 21.11.2021.
//

import Alamofire

extension Session {
    static let custom: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        let sessionManager = Session(configuration: configuration)
        
        return sessionManager
    }()
}
