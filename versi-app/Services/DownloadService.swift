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
}
