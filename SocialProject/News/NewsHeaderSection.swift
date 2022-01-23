//
//  HeaderSectionCell.swift
//  SocialProject
//
//  Created by Irina Kuligina on 08.01.2022.
//

import UIKit

class NewsHeaderSection: UITableViewHeaderFooterView {
    
    static let identifier: String = "NewsHeaderSection"

    var avatarImageView: UIImageView = UIImageView()
    var nameLabel: UILabel = UILabel()
    var postDateLabel: UILabel = UILabel()

    //var mainScreen: NewsTableViewController?
    
    private var screenBounds = UIScreen.main.bounds
    
    private var post: News?
    
    //Header новости
    func setHeaderSectionValues(item: News, group: Group) {
        self.post = item

        setupAvatarImageView()
        setupNameLabel()
        setupDateLabel()
    
        if let photo = group.photo,
           let url = URL(string: photo.photo_100) {
            avatarImageView.kf.setImage(with: url)
        }
        nameLabel.text = group.name
        postDateLabel.text = getStringFromDate(item.date)
    }
    private func setupAvatarImageView() {
        addSubview(avatarImageView)
        
        let frame = CGRect(
            x: 15,
            y: 15,
            width: 55,
            height: 55
        )
        avatarImageView.frame = frame
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.backgroundColor = Colors.background
        avatarImageView.layer.cornerRadius = frame.height / 2
        avatarImageView.clipsToBounds = true
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        
        let avatarImageViewFrame = avatarImageView.frame
        let originX = avatarImageViewFrame.maxX + 15
        let frame = CGRect(
            x: originX,
            y: 15,
            width: screenBounds.width - originX - 15,
            height: 19
        )
        nameLabel.frame = frame
        nameLabel.textColor = Colors.text
        nameLabel.backgroundColor = Colors.background
        nameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
    }
    
    private func setupDateLabel() {
        addSubview(postDateLabel)
        
        let nameLabelFrame = nameLabel.frame
        let frame = CGRect(
            x: nameLabelFrame.origin.x,
            y: nameLabelFrame.maxY + 5,
            width: nameLabelFrame.width,
            height: 16
        )
        postDateLabel.frame = frame
        postDateLabel.textColor = Colors.text
        postDateLabel.backgroundColor = Colors.background
        postDateLabel.font = .systemFont(ofSize: 13, weight: .light)
    }
    
    private func getStringFromDate(_ unixTimestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let string = dateFormatter.string(from: date)
        
        return string
    }
    
}
