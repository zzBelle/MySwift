//
//  FBMeUser.swift
//  JJFacebookMe
//
//  Created by admin on 2019/8/7.
//  Copyright © 2019 JJ. All rights reserved.
//

import UIKit

class FBMeUser {
    var name: String
    var avatarName: String
    var education: String
    
    init (name: String, avatarName: String = "bayMax", education: String) {
        self.name = name
        self.avatarName = avatarName
        self.education = education
    }
}
