//
//  GroupsCollectionCollectionViewController.swift
//  SocialProject
//
//  Created by Irina Kuluigina on 28.11.2021.
//

import UIKit
import RealmSwift
import FirebaseFirestore

class GroupsCollectionViewController: UICollectionViewController {
    
    //private let reuseIdentifier = "PostCollectionViewCell"
    let reuseIdentifierCell = "GroupImageCollectionViewCell"
    let reuseIdentifierHeader = "HeaderGroupSectionCollectionReusableView"
    var groupData: Group!
    var posts: Results<Image>!
    var token: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: reuseIdentifierCell, bundle: nil), forCellWithReuseIdentifier: reuseIdentifierCell)
   
        collectionView.register(UINib(nibName: reuseIdentifierHeader, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifierHeader)
        collectionView.collectionViewLayout = setupCollectionViewLayout()
        view.backgroundColor = Colors.palePurplePantone
        
        setupAddButton()
        
    }
    private func setupAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonTapped))
        
        guard let userID = UserSession.instance.userID else { return }
        let db = Firestore.firestore()
        let groupsRef = db.collection("\(userID)-groups").document("\(groupData.id)")
        
        groupsRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            
            if let document = document, document.exists {
                self.navigationItem.rightBarButtonItem?.title = "Remove"
            } else {
                self.navigationItem.rightBarButtonItem?.title = "Add"
            }
        }
    }
    
    private func removeGroupGromFirestore() {
        guard let userID = UserSession.instance.userID else { return }
        let db = Firestore.firestore()
        
        db.collection("\(userID)-groups").document("\(groupData.id)").delete() { err in
            if let err = err {
                print("[Firebase]: Error removing document: \(err)")
            } else {
                print("[Firebase]: Document successfully removed!")
            }
        }
    }
    
    private func saveGroupToFirestore() {
        guard let userID = UserSession.instance.userID else { return }
        let db = Firestore.firestore()
        
        db.collection("\(userID)-groups").document("\(groupData.id)").setData(groupData.toFirestore(), merge: true)
    }
    
    private func manageGroupInFirestore() {
        guard let userID = UserSession.instance.userID else { return }
        let db = Firestore.firestore()
        let groupsRef = db.collection("\(userID)-groups").document("\(groupData.id)")
        
        groupsRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            
            if let document = document, document.exists {
                self.navigationItem.rightBarButtonItem?.title = "Add"
                self.removeGroupGromFirestore()
            } else {
                self.navigationItem.rightBarButtonItem?.title = "Remove"
                self.saveGroupToFirestore()
            }
        }
    }
    
    @objc func addButtonTapped() {
        manageGroupInFirestore()
    }

    private func loadImages(group: Group, network: @escaping (ImageList?) -> Void) {
        let groupID: Int = Int(-group.id)
        NetworkManager.shared.getPhotos(ownerID: String(groupID), count: 30, offset: 0, type: .wall) { imageList in
            DispatchQueue.main.async {
                guard let imageList = imageList else { return }

                DatabaseManager.shared.saveImageData(images: imageList.images)
                
                network(imageList)
            }
        }
    }
    
    func getImages(group: Group) {
        let groupID: Int = Int(-group.id)
        
        self.groupData = group
        self.posts = DatabaseManager.shared.loadImageDataBy(ownerID: groupID)
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
        
        loadImages(group: group) { (imageList) in
            DispatchQueue.main.async {
                   if let imageList = imageList {
                    DatabaseManager.shared.saveImageData(images: imageList.images)
                }
            }
        }
    }


    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierHeader, for: indexPath) as? HeaderGroupSectionCollectionReusableView {
            sectionHeader.contentView.backgroundColor = Colors.darkPalePurplePantone
            sectionHeader.profileImageView.roundView()
            sectionHeader.profileImageView.clipsToBounds = true
            sectionHeader.profileImageView.kf.setImage(with: URL(string: groupData.photo?.photo_200 ?? ""))
            
            sectionHeader.nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
            sectionHeader.nameLabel.textColor = Colors.text
            sectionHeader.nameLabel.text = groupData.name
            
            return sectionHeader
        }
        return UICollectionReusableView()
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: CGFloat(collectionView.frame.size.width), height: CGFloat(125))

    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCell, for: indexPath) as! GroupImageCollectionViewCell
        
        cell.setValues(item: posts[indexPath.item])
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PhotoViewerViewController") as! PhotoViewerViewController
        
        
        let images: [Image] = posts.map { $0 }
        
        vc.getPhotosData(photos: images, currentIndex: indexPath.item)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
}
    extension GroupsCollectionViewController: UICollectionViewDelegateFlowLayout  {
        func setupCollectionViewLayout() -> UICollectionViewFlowLayout {
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            let width = UIScreen.main.bounds.width / 3

            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: width, height: width)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0

            return layout
        }
    }


