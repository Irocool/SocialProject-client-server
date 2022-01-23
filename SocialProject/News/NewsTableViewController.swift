//
//  NewsTableViewController.swift
//  SocialProject
//
//  Created by Irina Kuligina on 31.10.2021.
//

import UIKit
import Alamofire

class NewsTableViewController: UITableViewController {
    
    var request: Request?

    var newsArray: [News] = []
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(NewsHeaderSection.self, forCellReuseIdentifier: NewsHeaderSection.identifier)
        tableView.register(NewsTextSectionCell.self, forCellReuseIdentifier: NewsTextSectionCell.identifier)
        tableView.register(NewsFooterSection.self, forCellReuseIdentifier: NewsFooterSection.identifier)
        tableView.register(NewsImageSectionCell.self, forCellReuseIdentifier: NewsImageSectionCell.identifier)        //tableView.rowHeight = UITableView.automaticDimension
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
                self.tableView.reloadData()
                completion()
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
        

            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsImageSectionCell.identifier, for: indexPath) as! NewsImageSectionCell
                guard let image = newsArray[indexPath.section].photo else { return UITableViewCell() }
                
                cell.setPostImage(url: image.url)
                return cell
                
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextSectionCell.identifier, for: indexPath) as! NewsTextSectionCell
                let text = newsArray[indexPath.section].text
                cell.configure(text)
                return cell
            
            default:
                return UITableViewCell()
            }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsHeaderSection.identifier) as? NewsHeaderSection

            headerView?.setHeaderSectionValues(item: newsArray[section], group: groups[section])
           

            return headerView
            
        }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
        
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsFooterSection.identifier) as! NewsFooterSection
            footerView.setFooterSectionValues(item: newsArray[section], group: groups[section])
            return footerView
        }
        
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 50
        }
        
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
