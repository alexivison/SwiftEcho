//
//  Channel.swift
//  LaravelEchoTest
//
//  Created by tuominen-aleksi on 2019/04/03.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation
import SocketIO

class Channel: ChannelType {

    private var echoConfig: EchoClientConfiguration
    
    /**
     Create new Channel
     
     - Parameter options: options
     */
    init (echoConfig: EchoClientConfiguration) {
        self.echoConfig = echoConfig
    }
    
    /**
     Listen for an event on the channel instance.
     
     - Parameters:
        - event: Event name
        - callback: Normal callback
     - Returns: The channel itself
     */
    func listen(_ event: String, _ callback: @escaping NormalCallback) -> ChannelType {
        return self
    }
    
    /**
     Listen for an event on the channel instance.
     
     - Parameter callback: Normal callback
     - Returns: The channel itself
     */
    func notification(_ callback: @escaping NormalCallback) -> ChannelType {
        return self.listen(".Illuminate.Notifications.Events.BroadcastNotificationCreated", callback)
    }
    
    /**
     Listen for a whisper event on the channel instance.
     
     - Parameters:
        - event: Event name
        - callback: Normal callback
     - Returns: The channel itself
     */
    func listenForWhisper(_ event: String, _ callback: @escaping NormalCallback) -> ChannelType {
        return self.listen(".client-" + event, callback)
    }
    
    // Unsubscribe from channel and ubind event callbacks.
    func unsubscribe() {}
    
    // Subscribe to a Socket.io channel.
    func subscribe() {}
}
