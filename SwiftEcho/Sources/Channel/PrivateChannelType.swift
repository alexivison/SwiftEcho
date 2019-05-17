//
//  EchoPrivateChannel.swift
//  LaravelEchoTest
//
//  Created by tuominen-aleksi on 2019/04/03.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation
import SocketIO

public protocol PrivateChannelType: ChannelType {

    /**
     Trigger client event on the channel.
     
     - Parameters:
        - eventName: Event name
        - data: Data send
     - Returns: The private channel itself
     */
    func whisper(eventName: String, data: [AnyObject]) -> PrivateChannelType
}
