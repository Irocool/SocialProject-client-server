//
//  NewsTableViewController.swift
//  SocialProject
//
//  Created by Irina Kuligina on 31.10.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
        
    private let reuseIdentifier = "NewsTableViewCell"
    
    var newsArray: [News] = []
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 600
        tableView.backgroundColor = Colors.palePurplePantone
    }
    
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "To Top", style: .plain, target: self, action: #selector(topButtonTapped))
            
            loadNews()
        }
        
        @objc func topButtonTapped() {
            tableView.setContentOffset(.zero, animated: true)
        }
        
        private func loadNews() {
            NetworkManager.shared.loadFeed(count: 200) { [weak self] (feedResponse) in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.newsArray = feedResponse.newsArray
                    self.groups = feedResponse.groups
                    self.tableView.reloadData()
                }
            }
        }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NewsTableViewCell

        var groupToSet = Group()
        let newsPost = newsArray[indexPath.item]
        
        for group in groups {
            if group.id == newsPost.sourceID || -group.id == newsPost.sourceID {
                groupToSet = group
                break;
            }
        }
        
        cell.setValues(item: newsPost, group: groupToSet)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Before animation
        cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        cell.alpha = 0.0
        
        // Animation
        UIView.animate(withDuration: 1.0) {
            cell.transform = .identity
            cell.alpha = 1.0
        }
    }
}
