//
//  Service.swift
//  AdvancedTweeter
//
//  Created by Samuel Tse on 16/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import UIKit

typealias CompletionHandler = (_ Success: Bool) -> ()

public class Service: NSObject {
    static let shared = Service()
    
    func fetchMessages(completion: @escaping ([Message]?, Error?) -> ()) {
        let urlString = "http://sam.yekunxiao.com/getallmessages.php"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch messages:", err)
                return
            }
            // check response
            guard let data = data else { return }
            do {
                let msgs = try JSONDecoder().decode([Message].self, from: data)
                DispatchQueue.main.async {
                    completion(msgs, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
        }.resume()
    }
    
    func uploadMessage(message: Message, completion: @escaping CompletionHandler) {
        let urlString = "http://sam.yekunxiao.com/putmessage.php"
        guard let url = URL(string: urlString) else { return }
        let parameterDictionary = ["userName" : message.userName, "message" : message.message, "timeStamp" : message.timeStamp]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
                completion(true)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                    completion(false)
                }
            }
            if let error = error {
                print(error)
            }
        }.resume()
    }
}
