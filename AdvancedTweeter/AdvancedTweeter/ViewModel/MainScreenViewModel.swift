//
//  MainScreenViewModel.swift
//  AdvancedTweeter
//
//  Created by Samuel Tse on 16/4/19.
//  Copyright © 2020 Samuel Tse. All rights reserved.
//

import Foundation

class MainScreenViewModel {
    fileprivate var messageModels: [Message] = []
    
    init(model: [Message]? = nil) {
        if let inputModel = model{
            messageModels = inputModel
        }
    }
    
    public var num: Int {
        return self.messageModels.count
    }
    
    public var messages: [Message] {
        return messageModels
    }
}
extension MainScreenViewModel {
    func appendNewMessage(message: Message) {
        messageModels.insert(message, at: 0)
    }
    func loadAllMessages(completion: @escaping CompletionHandler) {
        Service.shared.fetchMessages { (messages, err) in
            if let err = err {
                print("Failed to fetch messages:", err)
                completion(false)
            }
            self.messageModels = messages ?? []
            completion(true)
        }
    }
}
