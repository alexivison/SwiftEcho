//
//  EchoPresenceChannel.swift
//  LaravelEchoTest
//
//  Created by tuominen-aleksi on 2019/04/03.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation
import SocketIO

public protocol PresenceChannelType: ChannelType {

    /**
     Register a callback to be called anytime the member list changes.
     
     - Parameter callback: Normal callback
     - Returns: The presence channel itself
     */
    @discardableResult func here(callback: @escaping NormalCallback) -> PresenceChannelType
    
    /**
     Listen for someone joining the channel.
     
     - Parameter callback: Normal callback
     - Returns: The presence channel itself
     */
    @discardableResult func joining(callback: @escaping NormalCallback) -> PresenceChannelType
    
    /**
     Listen for someone leaving the channel.
     
     - Parameter callback: Normal callback
     - Returns: the Presence channel itself
     */
    @discardableResult func leaving(callback: @escaping NormalCallback) -> PresenceChannelType
}
