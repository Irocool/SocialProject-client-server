//
//  NewsFooterSection.swift
//  SocialProject
//
//  Created by Irina Kuligina on 18.01.2022.
//
import UIKit

class NewsFooterSection: UITableViewHeaderFooterView {
    static let identifier: String = "NewsFooterSection"

    var likeButton: UIButton = UIButton()
    var commentButton: UIButton = UIButton()
    var repostButton: UIButton = UIButton()
    var viewsImageView: UIImageView = UIImageView()
    var viewsCountLabel: UILabel = UILabel()

    private let likeImage = UIImage(systemName: "heart.fill")!
    private let dislikeImage = UIImage(systemName: "heart")!
    
    //var mainScreen: NewsTableViewController?
    
    private var screenBounds = UIScreen.main.bounds
    
    private var post: News?
    
    private func setupLikeButton(_ numberOfLikes: String) {
        addSubview(likeButton)
        
        layoutLikeButton(numberOfLikes: numberOfLikes)
        
        likeButton.tintColor = .red
        likeButton.setTitle(numberOfLikes, for: .normal)
        likeButton.setTitleColor(Colors.text, for: .normal)
        likeButton.titleLabel?.font = .systemFont(ofSize: 14)
        likeButton.backgroundColor = Colors.background
        likeButton.addTarget(self, action: #selector(likeButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func layoutLikeButton(numberOfLikes: String) {
       
        let frame = CGRect(
            x: 10,
            y: 15,
            width: CGFloat(25 + numberOfLikes.count*10),
            height: 21
        )
        likeButton.frame = frame
    }
    
    private func setupCommentButton(_ numberOfComments: String) {
        addSubview(commentButton)
        
        layoutCommentButton(numberOfComments: numberOfComments)
        
        commentButton.setTitle(numberOfComments, for: .normal)
        commentButton.setImage(UIImage(systemName: "text.bubble")!, for: .normal)
        commentButton.tintColor = Colors.brand
        commentButton.setTitleColor(Colors.text, for: .normal)
        commentButton.titleLabel?.font = .systemFont(ofSize: 14)
        commentButton.backgroundColor = Colors.background
        commentButton.addTarget(self, action: #selector(commentButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func layoutCommentButton(numberOfComments: String) {
        let likeButtonFrame = likeButton.frame
        let frame = CGRect(
            x: likeButtonFrame.maxX + 5,
            y: likeButtonFrame.origin.y,
            width: CGFloat(25 + numberOfComments.count*10),
            height: 22
        )
        commentButton.frame = frame
    }
    
    private func setupRepostButton(_ numberOfReposts: String) {
        addSubview(repostButton)
        
        layoutRepostButton(numberOfReposts: numberOfReposts)
        
        repostButton.setTitle(numberOfReposts, for: .normal)
        repostButton.setImage(UIImage(systemName: "arrowshape.turn.up.left")!, for: .normal)
        repostButton.tintColor = Colors.brand
        repostButton.setTitleColor(Colors.text, for: .normal)
        repostButton.titleLabel?.font = .systemFont(ofSize: 14)
        repostButton.backgroundColor = Colors.background
        repostButton.addTarget(self, action: #selector(repostButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func layoutRepostButton(numberOfReposts: String) {
        let commentButtonFrame = commentButton.frame
        let frame = CGRect(
            x: commentButtonFrame.maxX + 5,
            y: commentButtonFrame.origin.y,
            width: CGFloat(25 + numberOfReposts.count*10),
            height: 22
        )
        repostButton.frame = frame
    }
    
    private func setupViewsCountLabel(_ viewsCount: String) {
        addSubview(viewsCountLabel)
        addSubview(viewsImageView)
        
        layoutViewsCountLabel(viewsCount: viewsCount)
        
        viewsCountLabel.text = viewsCount
        viewsCountLabel.textColor = Colors.text
        viewsCountLabel.font = .systemFont(ofSize: 14)
        viewsCountLabel.backgroundColor = Colors.background
        
        viewsImageView.image = UIImage(systemName: "eye")
        viewsImageView.tintColor = Colors.brand
        viewsImageView.backgroundColor = Colors.background
    }
    
    private func layoutViewsCountLabel(viewsCount: String) {
        let likeButtonFrame = likeButton.frame
        let width = CGFloat(10 * viewsCount.count)
        let viewsCountLabelFrame = CGRect(
            x: screenBounds.maxX - width - 5,
            y: likeButtonFrame.origin.y,
            width: CGFloat(11 * viewsCount.count),
            height: 20
        )
        viewsCountLabel.frame = viewsCountLabelFrame
    }
    
    private func changeLikeButtonImage() {
        guard let post = post else { return }
        
        if post.isUserLikes {
            likeButton.setImage(dislikeImage, for: .normal)
            self.post?.likesCount -= 1
        } else {
            likeButton.setImage(likeImage, for: .normal)
            self.post?.likesCount += 1
        }
        
        self.post?.isUserLikes = !post.isUserLikes
        let likesCount = String(self.post?.likesCount ?? 0)
        self.likeButton.setTitle(likesCount, for: .normal)
    }
    
    func setFooterSectionValues(item: News, group: Group) {
        self.post = item
      
        setupLikeButton(String(item.likesCount))
        setLikeButtonState(isUserLikes: item.isUserLikes)
        setupCommentButton(String(item.repostCount))
        setupRepostButton(String(item.commentCount))
        setupViewsCountLabel(String(item.viewsCount))
    }
    
    private func setLikeButtonState(isUserLikes: Bool) {
        if isUserLikes {
            likeButton.setImage(likeImage, for: .normal)
        } else {
            likeButton.setImage(dislikeImage, for: .normal)
        }
    }
    
    private func setNewLikeValueWithAnimation(post: News) {
        UIView.transition(with: likeButton, duration: 0.8, options: [.curveEaseOut, .transitionCurlUp]) {
            self.likeButton.setTitle(String(post.likesCount), for: .normal)
        } completion: { (state) in }
    }
    
    @objc func likeButtonPressed(_ sender: UIButton) {
        changeLikeButtonImage()
    }
    
    @objc func commentButtonPressed(_ sender: UIButton) {
        print(#function)
    }
    
    @objc func repostButtonPressed(_ sender: UIButton) {
        print(#function)
    }}
