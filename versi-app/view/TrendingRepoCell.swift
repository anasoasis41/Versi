//
//  TrendingRepoCell.swift
//  versi-app
//
//  Created by Anas Riahi on 11/8/19.
//  Copyright © 2019 Anas Riahi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingRepoCell: UITableViewCell {

    var disposeBag = DisposeBag()
    
    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var repoDescLbl: UILabel!
    @IBOutlet weak var numberOfForksLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var contributorsLbl: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var viewRedmeBtn: RoundedBorderButton!
    
    private var repoUrl: String?
    
    func configureCell(repo: Repo) {
        repoImageView.image = repo.image
        repoNameLbl.text = repo.name
        repoDescLbl.text = repo.description
        numberOfForksLbl.text = String(describing: repo.numberOfForks)
        languageLbl.text = repo.language
        contributorsLbl.text = String(describing: repo.numberOfContributors)
        repoUrl = repo.repoUrl
        
        viewRedmeBtn.rx.tap.subscribe(onNext: {
            self.window?.rootViewController?.presentSFSafariVCFor(url: self.repoUrl!)
        })
        .disposed(by: disposeBag)
    }
    
    override func layoutSubviews() {
        backView.layer.cornerRadius = 15
        backView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        backView.layer.shadowOpacity = 0.25
        backView.layer.shadowRadius = 5.0
        backView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
