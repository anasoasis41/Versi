//
//  TrendingFeedVC.swift
//  versi-app
//
//  Created by Anas Riahi on 11/7/19.
//  Copyright © 2019 Anas Riahi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingFeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let refreshControll = UIRefreshControl()
    
    var dataSource = PublishSubject<[Repo]>()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refreshControll
        refreshControll.tintColor = #colorLiteral(red: 0.2666666667, green: 0.4509803922, blue: 0.9137254902, alpha: 1)
        refreshControll.attributedTitle = NSAttributedString(string: "Fetching Hot Github Repos 🔥", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2666666667, green: 0.4509803922, blue: 0.9137254902, alpha: 1), NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 16.0)!])
        refreshControll.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        fetchData()
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "trendingRepoCell")) { (row, repo: Repo, cell: TrendingRepoCell) in
            cell.configureCell(repo: repo)
        }.disposed(by: disposeBag)
    }

    @objc func fetchData() {
        DownloadService.instance.downloadTrendingRepos { (trendingRepoArray) in
            self.dataSource.onNext(trendingRepoArray)
            self.refreshControll.endRefreshing()
        }
    }

}

