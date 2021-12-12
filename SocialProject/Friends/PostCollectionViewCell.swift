//
//  PostCollectionViewCell.swift
//  SocialProject
//
//  Created by Irina Kuligina on 27.10.2021.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    //private var post: Post?
    private var post: Image?
    
    private let likeImage = UIImage(systemName: "heart.fill")!
    private let dislikeImage = UIImage(systemName: "heart")!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .cyan
        
        setupImageView()
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
    }
    
    private func setupLikeButton() {
        guard let post = post else { return }
        
        if post.likes.userLikes == false {
            likeButton.setImage(dislikeImage, for: .normal)
        } else {
            likeButton.setImage(likeImage, for: .normal)
        }
    }
    
    func setValues(item: Image) {
        post = item
        
        let imageData = NetworkManager.shared.loadImageFrom(url: item.photo200.url)
        if let imageData = imageData,
           let image = UIImage(data: imageData) {
            imageView.image = image
        } else {
            if let image = UIImage(named: "default-profile") {
                imageView.image = (image)
            }
        }
        setupLikeButton()
    }
    
  //  private func changeLikeState() {
  //      guard let post = post else { return }
  //
 //       let userId = post.ownerId
 //       let postId = post.id
        //
//        for i in 0..<User.database[userId].posts.count {
//            if postId == User.database[userId].posts[i].id {
//                User.database[userId].posts[i].changeLikeState()
//            }
//        }
        
//        self.post?.changeLikeState()
//    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        guard let post = self.post else { return }
        
        if post.likes.userLikes == false {
            likeButton.setImage(likeImage, for: .normal)
        } else {
            likeButton.setImage(dislikeImage, for: .normal)
        }
        
        self.post?.likes.userLikes = !post.likes.userLikes
}
}
