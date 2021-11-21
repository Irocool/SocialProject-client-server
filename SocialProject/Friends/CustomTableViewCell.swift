//
//  CustomTableViewCell.swift
//  SocialProject
//
//  Created by Irina Kuligina on 20.10.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarView: CustomAvatarView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = Colors.palePurplePantone
        setupAvatarView()
    }
    
    func setValues(item: CellModel) {
        avatarView.setImage(item.image)
        nameLabel.text = item.name
    }
    
    func setupAvatarView() {
       let tap = UITapGestureRecognizer(target: self, action: #selector(self.avatarViewTapped(_:)))
        avatarView.addGestureRecognizer(tap)
    }
    
    @objc func avatarViewTapped(_ sender: UITapGestureRecognizer) {
        animateAvatarView()
    }
    
    private func animateAvatarView() {
        UIView.animate(withDuration: 1.3, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [.autoreverse], animations: {
            self.avatarView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }, completion: { (state) in
            self.avatarView.transform = .identity
        }

    ) }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
