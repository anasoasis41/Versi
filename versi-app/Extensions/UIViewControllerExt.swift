//
//  UIViewControllerExt.swift
//  versi-app
//
//  Created by Anas Riahi on 11/13/19.
//  Copyright © 2019 Anas Riahi. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentSFSafariVCFor(url: String) {
        let readmeURL = URL(string: url + readmeSegment)
        let safariVC = SFSafariViewController(url: readmeURL!)
        present(safariVC, animated: true, completion: nil)
    }
}
