//
//  NullPrivateChannel.swift
//  SwiftEcho
//
//  Created by tuominen-aleksi on 2019/05/22.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation
import SocketIO

class NullPrivateChannel: NullChannel, PrivateChannelType {
    
    override init() {}
    
    func whisper(eventName: String, data: [AnyObject]) -> PrivateChannelType {
        return self
    }    
}
