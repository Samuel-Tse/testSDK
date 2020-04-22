//
//  MessageViewModel.swift
//  AdvancedTweeter
//
//  Created by Samuel Tse on 16/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import UIKit

public class NewMessageViewModel {
    
    private let messageModel: Message
    private var processedMessage: [Message] = []
    
    public init(messageModel: Message) {
        self.messageModel = messageModel
    }
    
    public var username: String {
        return messageModel.userName
    }
    
    public var message: String {
        return messageModel.message
    }
    
    public var timeStamp: String {
        return messageModel.timeStamp
    }
    
    public var processedMessagesString: [String] {
        return processMessage(messageModel.message)
    }
    public var processedMessagesModel: [Message] {
        return processedMessage
    }
}
extension NewMessageViewModel {
    func uploadMessageToTweet(_ completionHandler:@escaping () -> ()) {
        let messages = processedMessagesString
        for i in 0..<messages.count{
            DispatchQueue.main.async {
                Service.shared.uploadMessage(message: self.processedMessagesModel[i], completion: { success in
                    print("Upload Result \(i): \(success)")
                })
            }
        }
        completionHandler()
    }
    
    //Functional Method, split message if its length is more than 50
    private func processMessage(_ message: String) -> [String] {
        var resultMessage: [Message] = []
        var length = 50
        if message.count <= length {
            resultMessage.append( Message(message: message, userName: username, timeStamp: timeStamp) )
            processedMessage = resultMessage
            return [message]
        }else {
            length = 46 //Reserved 4 characters, e.g.: 1/3 and a whitespace
            var result: [String] = []
            var collectedWords = [String]()
            collectedWords.reserveCapacity(50)
            var count = 0
            let words = message.components(separatedBy: " ")
            for word in words {
                if word.count > 50 {
                    return ["ERROR"]
                }
                count += word.count + 1 //add 1 to include space
                if (count > length) {
                    // Reached the desired length
                    result.append(collectedWords.map { String($0) }.joined(separator: " ") )
                    collectedWords.removeAll(keepingCapacity: true)
                    count = word.count
                    collectedWords.append(word)
                } else {
                    collectedWords.append(word)
                }
            }
            // Append the remainder
            if !collectedWords.isEmpty {
                result.append(collectedWords.map { String($0) }.joined(separator: " "))
            }
            // Add prefix
            let chunks = result.count
            for i in 1...result.count {
                result[i-1] = "\(i)/\(chunks)" + " " + result[i-1]
                resultMessage.append( Message(message: result[i-1], userName: username, timeStamp: timeStamp) )
                processedMessage = resultMessage
            }
            return result
        }
    }
}
