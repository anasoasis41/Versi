//
//  RoundedBorderTextField.swift
//  versi-app
//
//  Created by Anas Riahi on 11/8/19.
//  Copyright © 2019 Anas Riahi. All rights reserved.
//

import UIKit

class RoundedBorderTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2018133672, green: 0.5552520079, blue: 0.9803921569, alpha: 1)])
        attributedPlaceholder = placeholder
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = frame.height / 2
        layer.borderColor = #colorLiteral(red: 0.2018133672, green: 0.5552520079, blue: 0.9803921569, alpha: 1)
        layer.borderWidth = 3
    }

}
