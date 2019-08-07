//
//  FBMeBaseCell.swift
//  JJFacebookMe
//
//  Created by admin on 2019/8/7.
//  Copyright © 2019 JJ. All rights reserved.
//

import UIKit

class FBMeBaseCell: UITableViewCell {

    static let identifier = "FBMeBaseCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        backgroundColor = Specs.color.white
        textLabel?.textColor = Specs.color.black
        textLabel?.font = Specs.fond.large
        detailTextLabel?.font = Specs.fond.small
        detailTextLabel?.textColor = Specs.color.gray
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
