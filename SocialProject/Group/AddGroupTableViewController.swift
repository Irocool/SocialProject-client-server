//
//  AddGroupTableViewController.swift
//  SocialProject
//
//  Created by Irina Kuligina on 12.10.2021.
//

import UIKit

class AddGroupTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        view.backgroundColor = Colors.palePurplePantone
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        cell.setValues(item: groups[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "GroupsCollectionViewController") as! GroupsCollectionViewController
        
        let group = groups[indexPath.row]
        vc.title = group.name
        vc.getImages(group: group)
        
        self.navigationController?.pushViewController(vc, animated: true)
//        NetworkManager.shared.getPhotos(ownerID: "-\(group.id)", count: 30, offset: 0, type: .wall) { [weak self] imageList in
//            DispatchQueue.main.async {
//                guard let self = self,
//                      let imageList = imageList else { return }
//
//                vc.posts = imageList.images
//                vc.title = group.name
//
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//        }
    }
    
    // MARK: - SearchBar setup
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NetworkManager.shared.getGroupsBy(searchRequest: searchText, count: 25, offset: 0) { [weak self] groupsList in
            DispatchQueue.main.async {
                guard let self = self,
                      let groupsList = groupsList else { return }
                self.groups = groupsList.groups
                self.tableView.reloadData()
            }
        }
    }
}
