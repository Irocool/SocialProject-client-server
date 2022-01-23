//
//  NewsImageSectionCell.swift
//  SocialProject
//
//  Created by Irina Kuligina on 18.01.2022.
//

import UIKit

class NewsImageSectionCell: UITableViewCell {

    static let identifier: String = "NewsImageSectionCell"

    var postImageView: UIImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }

    private func setupPostImageView(_ photo: VKImage) {
        addSubview(postImageView)
        
        //layoutPostImageView(photo: photo)
        setPostImage(url: photo.url)
        
        postImageView.clipsToBounds = true
        postImageView.backgroundColor = Colors.background
        
//        let imageTapped = UITapGestureRecognizer(target: self, action: #selector(handleImageTapped))
//        postImageView.isUserInteractionEnabled = true
//        postImageView.addGestureRecognizer(imageTapped)
    }
    
    func setPostImage(url: String) {
        guard let url = URL(string: url) else {
            postImageView.isHidden = true
            return
        }
        postImageView.isHidden = false
        postImageView.kf.setImage(with: url)
    }

    private func setConstraints() {

        contentView.addSubview(postImageView)

        let topConstraint = postImageView.topAnchor.constraint(equalTo: contentView.topAnchor)

        NSLayoutConstraint.activate([
            topConstraint,
            postImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            postImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            postImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            postImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor)
        ])

        topConstraint.priority = .init(999)
    }
}
