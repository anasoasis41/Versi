//
//  TrendingFeedVC.swift
//  versi-app
//
//  Created by Anas Riahi on 11/7/19.
//  Copyright © 2019 Anas Riahi. All rights reserved.
//

import UIKit

class TrendingFeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        DownloadService.instance.downloadTrendingReposDictArray { (reposDictArray) in
            print(reposDictArray)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trendingRepoCell", for: indexPath) as? TrendingRepoCell
            else { return UITableViewCell() }
        
        let repo = Repo(image: UIImage(named: "searchIconLarge")!, name: "SWIFT", description: "Apple's programming language", numberOfForks: 423, language: "Swift", numberOfContributors: 562, repoUrl: "www.google.com")
        cell.configureCell(repo: repo)
        return cell
    }


}

