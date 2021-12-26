//
//  FriendsCollectionViewController.swift
//  SocialProject
//
//  Created by Irina Kuligina on 12.10.2021.
//

import UIKit
import RealmSwift

class FriendsCollectionViewController: UICollectionViewController {
    private let reuseIdentifier = "PostCollectionViewCell"
    
    var posts: Results<Image>!
    var token: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: "PostCollectionViewCell")

        view.backgroundColor = Colors.palePurplePantone

    }
    private func loadImages(user: User, network: @escaping (ImageList?) -> Void) {
        NetworkManager.shared.getPhotos(ownerID: String(user.id), count: 30, offset: 0, type: .profile) { imageList in
            DispatchQueue.main.async {
                guard let imageList = imageList else { return }
                
                DatabaseManager.shared.saveImageData(images: imageList.images)
                
                network(imageList)
            }
        } //failure: {  }
    }
    
    func getImages(user: User) {
        self.posts = DatabaseManager.shared.loadImageDataBy(ownerID: user.id)
        self.token = posts.observe(on: DispatchQueue.main, { [weak self] (changes) in
            guard let self = self else { return }
            
            switch changes {
            case .update:
                self.collectionView.reloadData()
                break
            case .initial:
                self.collectionView.reloadData()
            case .error(let error):
                print("Error in \(#function). Message: \(error.localizedDescription)")
            }
        })
        
        loadImages(user: user) { (imageList) in
            DispatchQueue.main.async {
                if let imageList = imageList {
                    DatabaseManager.shared.saveImageData(images: imageList.images)
                }
            }
        }
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
        
        let images: [Image] = posts.map { $0 }
        
        vc.getPhotosData(photos: images, currentIndex: indexPath.item)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
