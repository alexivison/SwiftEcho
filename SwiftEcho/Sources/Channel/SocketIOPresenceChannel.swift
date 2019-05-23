//
//  SocketIOPresenceChannel.swift
//  LaravelEchoTest
//
//  Created by tuominen-aleksi on 2019/04/03.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation
import SocketIO

class SocketIOPresenceChannel: SocketIoChannel, PresenceChannelType {
    
    /**
     Create a new class instance.
     
     - Parameters:
        - socket: The socket instance
        - name: The channel name
        - options: Options for the channel
     */
    override init(socket: SocketIOClient, name: String, echoConfig: EchoClientConfiguration) {
        super.init(socket: socket, name: name, echoConfig: echoConfig)
    }
    
    /**
     Register a callback to be called anytime the member list changes.
     
     - Parameter callback: Normal callback
     - Returns: The presence channel itself
     */
    func here(_ callback: @escaping NormalCallback) -> PresenceChannelType {
        self.socket.on("presence:subscribed", callback: callback)
        return self;
    }
    
    /**
     Listen for someone joining the channel.
     
     - Parameter callback: Normal callback
     - Returns: The presence channel itself
     */
    func joining(_ callback: @escaping NormalCallback) -> PresenceChannelType {
        self.socket.on("presence:joining", callback: callback)
        return self;
    }
    
    /**
     Listen for someone leaving the channel.
     
     - Parameter callback: Normal callback
     - Returns: The presence channel itself
     */
    func leaving(_ callback: @escaping NormalCallback) -> PresenceChannelType {
        self.socket.on("presence:leaving", callback: callback)
        return self;
    }
}
