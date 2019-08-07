//
//  JJStopWatch.swift
//  JJStopWatch
//
//  Created by admin on 2019/8/6.
//  Copyright © 2019 JJ. All rights reserved.
//

import Foundation

class JJStopWatch: NSObject {
    var counter : Double
    var timer : Timer
    
    override init() {
        counter = 0.0
        timer = Timer()
    }
}
