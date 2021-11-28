//
//  GroupTableViewController.swift
//  SocialProject
//
//  Created by Irina Kuligina on 12.10.2021.
//

import UIKit

class GroupTableViewController: UITableViewController {
    
    var userGroups: [Group] = []
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        
        view.backgroundColor = Colors.palePurplePantone
        
        loadGroupList()
        
    }
    
    private func loadGroupList() {
        NetworkManager.shared.loadGroupsList(count: 0, offset: 0) { [weak self] groupsList in
            DispatchQueue.main.async {
                guard let self = self,
                      let groupsList = groupsList else { return }
                self.userGroups = groupsList.groups
                self.tableView.reloadData()
            }
        }
    }    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroups.count
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        cell.setValues(item: userGroups[indexPath.row])
        
        return cell
    }
    
  //  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  //      tableView.deselectRow(at: indexPath, animated: true)
 //   }
  //  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   //     let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "GroupTableViewController") as! GroupTableViewController
        
    //    let group = userGroups[indexPath.row]
        
    //    NetworkManager.shared.getPhotos(ownerID: "-\(group.id)", count: 30, offset: 0, type: .wall) { [weak self] imageList in
    //        DispatchQueue.main.async {
    //            guard let self = self,
   //                   let imageList = imageList else { return }
//
   //             vc.posts = imageList.images
   //             vc.title = group.name
                
   //             self.navigationController?.pushViewController(vc, animated: true)
    //        }
        }
   // }

  //  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
  //      if editingStyle == .delete {
            
  //          let id = addedGroups[indexPath.row].id
  //          Group.changeGroupAdded(by: id)
 //
 //           tableView.deleteRows(at: [indexPath], with: .fade)
 //       }
 //   }
    
//}
