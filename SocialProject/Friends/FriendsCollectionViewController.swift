//
//  FriendsCollectionViewController.swift
//  SocialProject
//
//  Created by Irina Kuligina on 12.10.2021.
//

import UIKit

class FriendsCollectionViewController: UICollectionViewController {
    private let reuseIdentifier = "PostCollectionViewCell"
    
    var posts: [Image] = []
    var loadedImages: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: "PostCollectionViewCell")

        view.backgroundColor = Colors.palePurplePantone

    }
    private func loadEveryImage(completion: @escaping () -> Void) {
        for post in posts {
            let imageData = NetworkManager.shared.loadImageFrom(url: post.photo200.url)
            if let imageData = imageData,
               let image = UIImage(data: imageData) {
                loadedImages.append(image)
            }
        }
        completion()
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PostCollectionViewCell
        
        cell.setValues(item: posts[indexPath.item])
        cell.frame = CGRect(x: 10, y: 10, width: 100, height: 500)     
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PhotoViewerViewController") as! PhotoViewerViewController
        
        
        loadEveryImage() { [weak self] in
            guard self != nil else { return }
        }
        vc.getPhotosData(photos: self.loadedImages, currentIndex: indexPath.item)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
