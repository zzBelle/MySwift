//
//  Constants.swift
//  JJToDo
//
//  Created by admin on 2019/8/9.
//  Copyright © 2019 JJ. All rights reserved.
//

import Foundation

struct Constants {
    static let MainBundleIdentifier = "Main"
    static let ItemListViewControllerIdentifier = "ItemListViewController"
    static let DetailViewControllerIdentifier = "DetialsViewController"
    static let InputViewControllerIdentifier = "InputViewController"
    
    static let ItemCellIdentifier = "ItemTableViewCell"
    static let userName = "Crystal"
    static let password = "123456"
}

extension Notification {
    static let ItemSelectedNotification = Notification.Name("ItemSelectedNotification")

}
