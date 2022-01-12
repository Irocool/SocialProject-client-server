//
//  NewsTextSectionCell.swift
//  SocialProject
//
//  Created by Irina Kuligina on 08.01.2022.
//

import UIKit

class NewsTextSectionCell: UITableViewCell {
    
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
    
//    private func layoutTextLabel(text: String) {
//        isExpandable = false
//        let postTextLabelFraim = frame
//
//        if text.isEmpty {
//            let origin = CGPoint(x: 10, y: postTextLabelFraim.maxY + 10)
//            postTextLabel.frame = CGRect(origin: origin, size: .zero)
//        } else {
//            let size = getLabelSize(label: postTextLabel)
//            var height = size.height
//            if size.height > maxHeight {
//                height = maxHeight
//                isExpandable = true
//            }
//            let frame = CGRect(
//                x: 10,
//                y: postTextLabelFraim.maxY + 10,
//                width: screenBounds.width - 20,
//                height: height
//            )
//            postTextLabel.frame = frame
//
//            if (isExpandable) {
//                setupMoreButton()
//            }
//        }
//    }
//
//    private func setupMoreButton() {
//        addSubview(moreButton)
//
//        layoutMoreButton()
//
//        moreButton.setTitle("Show more", for: .normal)
//        moreButton.setTitleColor(Colors.brand, for: .normal)
//        moreButton.tintColor = Colors.brand
//        moreButton.backgroundColor = Colors.background
//        moreButton.titleLabel?.font = .systemFont(ofSize: 15)
//    }
//
//    private func layoutMoreButton() {
//        let postTextLabelFrame = postTextLabel.frame
//        let frame = CGRect(
//            x: screenBounds.maxX - 82,
//            y: postTextLabelFrame.maxY - 5,
//            width: 77,
//            height: 30
//        )
//        moreButton.frame = frame
//    }
//
//    private func getLabelSize(label: UILabel) -> CGSize {
//        let labelSize: CGSize
//        if let labelText = label.text, !labelText.isEmpty {
//            labelSize = getLabelSize(text: labelText as NSString, font: label.font)
//        } else {
//            labelSize = .zero
//        }
//        return labelSize
//    }
//
//    private func getLabelSize(text: NSString, font: UIFont) -> CGSize {
//        let postTextFrame = postTextLabel.frame
//        let maxWidth = postTextFrame.width
//        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
//        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
//        let width = Double(rect.width)
//        let height = Double(rect.height)
//        return CGSize(width: ceil(width), height: ceil(height))
//    }
    
}
