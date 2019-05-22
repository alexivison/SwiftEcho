//
//  EchoChannel.swift
//  LaravelEchoTest
//
//  Created by tuominen-aleksi on 2019/04/03.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation
import SocketIO

public protocol ChannelType {
    
    /**
     Listen for an event on the channel instance.
     
     - Parameters:
        - event: Event name
        - callback: Normal callback
     - Returns: The channel itself
     */
    @discardableResult func listen(_ event: String, _ callback: @escaping NormalCallback) -> ChannelType
    
    /**
     Listen for an event on the channel instance.
     
     - Parameter callback: Normal callback
     - Returns: The channel itself
     */
    @discardableResult func notification(_ callback: @escaping NormalCallback) -> ChannelType
    
    /**
     Listen for a whisper event on the channel instance.
     
     - Parameters:
        - event: Event name
        - callback: Normal callback
     - Returns: The channel itself
     */
    @discardableResult func listenForWhisper(_ event: String, _ callback: @escaping NormalCallback) -> ChannelType
    
    // Unsubscribe from channel and ubind event callbacks.
    func unsubscribe()
    
    // Subscribe to a Socket.io channel.
    func subscribe()
}
