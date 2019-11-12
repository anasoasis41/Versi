//
//  DownloadService.swift
//  versi-app
//
//  Created by Anas Riahi on 11/8/19.
//  Copyright © 2019 Anas Riahi. All rights reserved.
//

import Foundation
import Alamofire

class DownloadService {
    static let instance = DownloadService()
    
    func downloadTrendingReposDictArray(completion: @escaping (_ reposDictArray: [Dictionary<String, Any>]) -> ()) {
        var trendingReposArray = [Dictionary<String, Any>]()
        
        Alamofire.request(trendingRepoUrl).responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String, Any> else { return }
            guard let reposDictionaryArray = json["items"] as? [Dictionary<String, Any>] else { return }
            for repoDict in reposDictionaryArray {
                if trendingReposArray.count <= 10 {
                    trendingReposArray.append(repoDict)
                } else {
                    break
                }
            }
            completion(trendingReposArray)
        }
    }
    
    func downloadTrendingRepos(completion: @escaping (_ reposArray: [Repo]) -> ()) {
        var reposArray = [Repo]()
        downloadTrendingReposDictArray { (trendingReposDictArray) in
            for dict in trendingReposDictArray {
                let repo = self.downloadTrendingRepo(fromDictionary: dict)
                reposArray.append(repo)
            }
            completion(reposArray)
        }
    }
    
    func downloadTrendingRepo(fromDictionary dict: Dictionary<String, Any>) -> Repo {
        //let avatarUrl = dict["avatar_url"] as! String
        let name = dict["name"] as! String
        let description = dict["description"] as! String
        let numberOfForks = dict["forks_count"] as! Int
        let language = dict["language"] as? String ?? ""
        let repoUrl = dict["html_url"] as! String
        
        let repo = Repo(image: UIImage(named: "searchIconLarge")!, name: name, description: description, numberOfForks: numberOfForks, language: language, numberOfContributors: 123, repoUrl: repoUrl)
       
        return repo
    }
}
