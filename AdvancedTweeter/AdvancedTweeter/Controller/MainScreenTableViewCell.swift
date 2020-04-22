//
//  MainScreenTableViewCell.swift
//  AdvancedTweeter
//
//  Created by Samuel Tse on 16/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import UIKit

class MainScreenTableViewCell: UITableViewCell {

    @IBOutlet weak var imageView_UserAvatar: RoundImageView!
    @IBOutlet weak var Label_UserName: UILabel!
    @IBOutlet weak var Label_Message: UILabel!
    @IBOutlet weak var Label_TimeStamp: UILabel!
    
    var messageViewModel: Message! {
        didSet {
            Label_UserName.text = messageViewModel.userName
            Label_Message.text = messageViewModel.message
            Label_TimeStamp.text = messageViewModel.timeStamp
        }
    }
}
