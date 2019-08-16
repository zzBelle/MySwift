//
//  ToDoItem.swift
//  JJToDo
//
//  Created by admin on 2019/8/9.
//  Copyright © 2019 JJ. All rights reserved.
//

import Foundation

struct ToDoItem {
    let title: String
    let itemDescription: String?
    let timestamp: Double?
    let location: Location?
    
    private let titleKey = "titleKey"
    private let itmeDescriptionKey = "itemDescriptionKey"
    private let timestapKey = "timestampkey"
    private let locationKey = "locationKey"
    
    var plistDict: [String:Any] {
        var dict = [String:Any]()
        
        dict[titleKey] = title
        if let itmeDescription  = itemDescription {
            dict[itmeDescriptionKey] = itemDescription
        }
        
        if let timestamp = timestamp {
            dict[timestapKey] = timestamp
        }
        
        if let location = location {
            let locationDic = location.plistDict
            dict[locationKey] = locationDic
        }
        return dict
    }
    
    init(title: String, itemDescription: String? = nil, timeStamp: Double? = nil, location: Location? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timeStamp
        self.location = location
    }
    
    init?(dict: [String: Any]) {
        guard let title = dict[titleKey] as? String else {
            return nil
        }
        
        self.title = title
        self.itemDescription = dict[itmeDescriptionKey] as? String
        self.timestamp = dict[timestapKey] as? Double
        if let locationDict = dict[locationKey] as? [String: Any] {
            self.location = Location(dict: locationDict)
        } else {
            self.location = nil
        }
    }
}

extension ToDoItem: Equatable {
    static func ==(lhs:ToDoItem, rhs: ToDoItem) -> Bool {
        return lhs.title == rhs.title && lhs.location?.name == rhs.location?.name
    }
}
