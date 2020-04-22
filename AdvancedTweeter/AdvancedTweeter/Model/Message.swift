//
//  Message.swift
//  AdvancedTweeter
//
//  Created by Samuel Tse on 16/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import Foundation

public struct Message: Decodable {
    let message: String
    let userName: String
//    let userAvatar: String
    let timeStamp: String
    
    init(message: String, userName: String, timeStamp: String) {
        
        self.message = message
        self.userName = userName
        self.timeStamp = timeStamp
    }
}
