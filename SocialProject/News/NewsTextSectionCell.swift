//
//  NewsTextSectionCell.swift
//  SocialProject
//
//  Created by Irina Kuligina on 08.01.2022.
//

import UIKit

class NewsTextSectionCell: UITableViewCell {
    
    static let identifier: String = "NewsTextSectionCell"

    private let postTextLabel: UILabel = {
        let newsTextLabel = UILabel()
        newsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTextLabel.numberOfLines = 0
        return newsTextLabel
    }()
    //var moreButton: UIButton = UIButton()
    //private let maxHeight: CGFloat = 200

    //var isExpanded: Bool = false
    //var isExpandable: Bool = false

    //var mainScreen: NewsTableViewController?

    //private var screenBounds = UIScreen.main.bounds

    //private var post: News?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupCell()
//    }
    
//    private func setupCell() {
//        self.contentView.backgroundColor = Colors.background
//        isExpanded = false
//        isExpandable = false
//    }
    //текст новости
    func configure(_ text: String?) {
        postTextLabel.text = text
        postTextLabel.textAlignment = .natural
        postTextLabel.textColor = Colors.text
        postTextLabel.backgroundColor = Colors.background
        postTextLabel.numberOfLines = 0
        postTextLabel.font = .systemFont(ofSize: 14)
        postTextLabel.lineBreakMode = .byTruncatingTail    }
    
    private func setConstraints() {
        contentView.addSubview(postTextLabel)
        
        let topConstraint = postTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor)

        NSLayoutConstraint.activate([
            topConstraint,
            postTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            postTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            postTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])

        topConstraint.priority = .init(999)
    }
    
}
