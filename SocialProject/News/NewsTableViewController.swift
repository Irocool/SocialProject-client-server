//
//  NewsTableViewController.swift
//  SocialProject
//
//  Created by Irina Kuligina on 31.10.2021.
//

import UIKit
import Alamofire

class NewsTableViewController: UITableViewController {
        
    private let reuseIdentifier1 = "NewsHeaderSectionCell"
    private let reuseIdentifire2 = "NewsTextSectionCell"
    
    //var sections: [Int] = [1, 2, 3, 4]
    var newsArray: [News] = []
    var groups: [Group] = []
    var nextFrom = ""
    var isLoading = false
    var request: Request?
    
    //private var testCell = NewsTableViewCell()
   // private var expandedCells: [IndexPath: NewsTableViewCell] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(NewsHeaderSectionCell.self, forCellReuseIdentifier: reuseIdentifier1)
        tableView.register(NewsTextSectionCell.self, forCellReuseIdentifier: reuseIdentifire2)
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.rowHeight = 600
        tableView.backgroundColor = Colors.palePurplePantone

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "To Top", style: .plain, target: self, action: #selector(topButtonTapped))
        setupRefreshControl()
        loadNews{}
    }
        
    @objc func topButtonTapped() {
        tableView.setContentOffset(.zero, animated: true)
    }
    private func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = Colors.brand
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() { loadNews() { [weak self] in
            guard let self = self else { return }
            
            // Dismiss the refresh control.
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
            }
        }

    }
    
    private func loadNews(completion: @escaping () -> Void) {
        self.request = NetworkManager.shared.loadFeed(count: 25, from: "") { [weak self] (feedResponse) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.newsArray = feedResponse.newsArray
                self.groups = feedResponse.groups
                self.nextFrom = feedResponse.nextFrom
                self.tableView.reloadData()
                completion()
            }
        }
    }

    private func loadNextNews() {
        print(#function)
        self.request = NetworkManager.shared.loadFeed(count: 15, from: nextFrom) { [weak self] (feedResponse) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.newsArray += feedResponse.newsArray
                self.groups += feedResponse.groups
                self.nextFrom = feedResponse.nextFrom
                self.isLoading = false
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsArray.count
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var groupToSet = Group()
        let newsPost = newsArray[indexPath.item]
        
        for group in groups {
            if group.id == newsPost.sourceID || -group.id == newsPost.sourceID {
                groupToSet = group
                break;
            }
        }
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! NewsHeaderSectionCell
            
            
                cell.setHeaderSectionValues(item: newsPost, group: groupToSet)
               // cell.mainScreen = self
            return cell
                
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifire2, for: indexPath) as! NewsTextSectionCell
                let text = newsArray[indexPath.item].text
                cell.configure(text)
                return cell
            
            default:
                return UITableViewCell()
            }

//    private func configureCell (cell: NewsTableViewCell, indexPath: IndexPath) {
//        var groupToSet = Group()
//        let newsPost = newsArray[indexPath.item]
//
//        for group in groups {
//            if group.id == newsPost.sourceID || -group.id == newsPost.sourceID {
//                groupToSet = group
//                break;
//            }
//        }
//        cell.setValues(item: newsPost, group: groupToSet)
//        cell.mainScreen = self
//    }

//        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        // Before animation
//        cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//        cell.alpha = 0.0
//        
//        // Animation
//        UIView.animate(withDuration: 1.0) {
//            cell.transform = .identity
//            cell.alpha = 1.0
//        }
//    }
}

}
