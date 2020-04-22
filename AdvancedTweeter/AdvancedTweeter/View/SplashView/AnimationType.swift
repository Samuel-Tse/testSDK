//
//  AnimationType.swift
//  AdvancedTweeter
//
//  Created by Samuel Tse on 14/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import Foundation

//---------------------------------
//--- Twitter: The default animation type is the Twitter App animation
//--- If required to call the API, call the heartbeat animation
//---------------------------------
public enum AnimationType: String{
    case twitter
    case heartBeat
}
