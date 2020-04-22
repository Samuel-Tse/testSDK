//
//  NewMessageViewController.swift
//  AdvancedTweeter
//
//  Created by Samuel Tse on 16/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import UIKit

protocol TweetMessageDelegate {
    func MessageOnTweet(messages: [Message])
}

class NewMessageViewController: UIViewController {

    @IBOutlet weak var imageView_Avatar: UIImageView!
    @IBOutlet weak var textView_Message: UITextView!
    @IBOutlet weak var button_Tweet: RoundedButton!
    
    var tweetMessageDelegate: TweetMessageDelegate?
    var userName = ""
    var newMessageViewModel: NewMessageViewModel!
    var messageModel: Message!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupData()
    }
    
    func setupUI() {
        setBackgroundColor()
        hideKeyboardWhenTappedAround()
        textView_Message.text = "What's happening?"
        textView_Message.textColor = UIColor.lightGray
        textView_Message.becomeFirstResponder()
        textView_Message.selectedTextRange = textView_Message.textRange(from: textView_Message.beginningOfDocument, to: textView_Message.beginningOfDocument)
        button_Tweet.isEnabled = false
        button_Tweet.backgroundColor = UIColor(rgb: 0x8092B0)
    }
    
    func setupData() {
        messageModel = Message(message: "", userName: "", timeStamp: "")
        newMessageViewModel = NewMessageViewModel(messageModel: messageModel)
    }

    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweetAction(_ sender: RoundedButton) {
        
        newMessageViewModel.uploadMessageToTweet { [unowned self] in
            self.tweetMessageDelegate?.MessageOnTweet(messages: self.newMessageViewModel.processedMessagesModel)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: - UITextViewDelegate
extension NewMessageViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView_Message.textColor == UIColor.lightGray {
            textView_Message.text = ""
            textView_Message.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView_Message.text == "" {
            
            textView_Message.text = "What's happening?"
            textView_Message.textColor = UIColor.lightGray
            button_Tweet.isEnabled = false
            button_Tweet.backgroundColor = UIColor(rgb: 0x8092B0)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        guard !(textView_Message.text == "") else {
            return
        }
        self.messageModel = Message(message: textView_Message.text, userName: userName, timeStamp: getCurrentDateTime())
        newMessageViewModel = NewMessageViewModel(messageModel: messageModel)
        button_Tweet.isEnabled = true
        button_Tweet.backgroundColor = UIColor(rgb: 0x6BAAE8)
    }
}
