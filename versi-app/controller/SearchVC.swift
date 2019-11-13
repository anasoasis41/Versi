//
//  SearchVC.swift
//  versi-app
//
//  Created by Anas Riahi on 11/8/19.
//  Copyright © 2019 Anas Riahi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchVC: UIViewController, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var searchField: RoundedBorderTextField!
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindElements()
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func bindElements() {
        let searchResultsObservable = searchField.rx.text
            .orEmpty // if is null transform to empty String
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .map {
                $0.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        }
        .flatMap { (query) -> Observable<[Repo]> in
            if query == "" {
                return Observable<[Repo]>.just([])
            } else {
                let url = searchUrl + query + starsDescendingSegment
                var searchRepos = [Repo]()
                
                return URLSession.shared.rx.json(url: URL(string: url)!).map {
                    let result = $0 as AnyObject
                    let items = result.object(forKey: "items") as? [Dictionary<String, Any>] ?? []
                    
                    for item in items {
                        guard let name = item["name"] as? String,
                            let description = item["description"] as? String,
                            let language = item["language"] as? String,
                            let forksCount = item["forks_count"] as? Int,
                            let repoUrl = item["html_url"] as? String
                        else { break }
                        
                        let repo = Repo(image: UIImage(named: "searchIconLarge")!, name: name, description: description, numberOfForks: forksCount, language: language, numberOfContributors: 0, repoUrl: repoUrl)
                        
                        searchRepos.append(repo)
                    }
                    return searchRepos
                }
            }
        }
        .observeOn(MainScheduler.instance)
        
        searchResultsObservable.bind(to: tableView.rx.items(cellIdentifier: "searchCell")) { (row, repo: Repo, cell: SearchCell) in
            cell.configureCell(repo: repo)
        }
        .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchCell else { return }
        let url = cell.repoUrl!
        self.presentSFSafariVCFor(url: url)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }

}
