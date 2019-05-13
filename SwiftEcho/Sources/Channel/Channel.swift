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
    private var options: [String: Any]
    
    /**
     Create new Channel
     
     - Parameter options: options
     */
    init (options: [String: Any]) {
        self.options = options
    }
    
    /**
     Listen for an event on the channel instance.
     
     - Parameters:
        - event: Event name
        - callback: Normal callback
     - Returns: The channel itself
     */
    func listen(event: String, callback: @escaping NormalCallback) -> ChannelType {
        return self
    }
    
    /**
     Listen for an event on the channel instance.
     
     - Parameter callback: Normal callback
     - Returns: The channel itself
     */
    func notification(callback: @escaping NormalCallback) -> ChannelType {
        return self.listen(event: ".Illuminate.Notifications.Events.BroadcastNotificationCreated", callback: callback)
    }
    
    /**
     Listen for a whisper event on the channel instance.
     
     - Parameters:
        - event: Event name
        - callback: Normal callback
     - Returns: The channel itself
     */
    func listenForWhisper(event: String, callback: @escaping NormalCallback) -> ChannelType {
        return self.listen(event: ".client-" + event, callback: callback)
    }
    
    // Unsubscribe from channel and ubind event callbacks.
    func unsubscribe() {}
    
    // Subscribe to a Socket.io channel.
    func subscribe() {}
}
