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
    func listen(event: String, callback: @escaping NormalCallback) -> ChannelType
    
    /**
     Listen for an event on the channel instance.
     
     - Parameter callback: Normal callback
     - Returns: The channel itself
     */
    func notification(callback: @escaping NormalCallback) -> ChannelType
    
    /**
     Listen for a whisper event on the channel instance.
     
     - Parameters:
        - event: Event name
        - callback: Normal callback
     - Returns: The channel itself
     */
    func listenForWhisper(event: String, callback: @escaping NormalCallback) -> ChannelType
    
    // Unsubscribe from channel and ubind event callbacks.
    func unsubscribe()
    
    // Subscribe to a Socket.io channel.
    func subscribe()
}
