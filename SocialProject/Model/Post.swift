//
//  Post.swift
//  SocialProject
//
//  Created by Irina Kuligina on 27.10.2021.
//

import UIKit

enum LikeState {
    case like
    case dislike
}

protocol PostModel {
    var ownerId: Int { get }
    
    var date: Date { get set }
    var image: UIImage { get set }
    var likeState: LikeState { get set }
    var text: String { get set }
}

struct Post: PostModel {
    let id: Int
    let ownerId: Int
    
    var image: UIImage
    var likeState: LikeState
    var date: Date
    var text: String
    
    var likesCount: Int
    var viewsCount: Int
    
    mutating func changeLikeState() {
        if likeState == .dislike {
            likeState = .like
            likesCount += 1
        } else {
            likeState = .dislike
            likesCount -= 1
        }
    }
}


