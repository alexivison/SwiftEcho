//
//  Echo.swift
//  LaravelEchoTest
//
//  Created by tuominen-aleksi on 2019/04/03.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation
import SocketIO

open class EchoClient {
    private var connector: ConnectorType
    private var options: [String: Any]
    
    /**
     Create a new class instance.

     - Parameters:
        - options: options
        - log: disable or enable log output
     */
    public init(options: [String: Any]) {
        self.options = options
        self.connector = SocketIOConnector(options: self.options)
    }
    
    /**
     Listen for an event

     - Parameters:
        - event: Event name
        - callback: Normal callback
     */
    open func on(_ event: String, callback: @escaping NormalCallback) {
        return self.connector.on(event, callback: callback)
    }
    
    /**
     Listen for a SocketIO event
     
     - Parameters:
        - event: Event name
        - callback: Normal callback
     */
    open func on(_ clientEvent: SocketClientEvent, callback: @escaping NormalCallback) {
        guard let socketIOConnector = self.connector as? SocketIOConnector else {
            return
        }
        return socketIOConnector.on(clientEvent: clientEvent, callback: callback)
    }
    
    /**
     Listen for an event on a channel instance.
     
     - Parameters:
        - channel: Channel name
        - event: Event name
        - callback: Normal callback
     - Returns: The listened channel
    */
    @discardableResult open func listen(channel: String, event: String, callback: @escaping NormalCallback) -> ChannelType {
        return self.connector.listen(channel: channel, event: event, callback: callback);
    }
    
    /**
     Get a channel instance by name.
     
     - Parameter Channel: channel name
     - Returns: The channel
     */
    open func join(channel: String) -> ChannelType {
        return self.connector.channel(name: channel);
    }

    /**
     Get a private channel instance by name.
     
     - Parameter Channel: channel name
     - Returns: The private channel
     */
    open func join(privateChannel: String) -> PrivateChannelType {
        return self.connector.privateChannel(name: privateChannel);
    }
    
    /**
     Get a presence channel instance by name.
     
     - Parameter Channel: channel name
     - Returns: The private channel
     */
    open func join(presenceChannel: String) -> PresenceChannelType {
        return self.connector.presenceChannel(name: presenceChannel)
    }
    
    /**
     Leave the given channel.
     
     - Parameter channel: The channel name
     */
    open func leave(channel: String) {
        self.connector.leave(name: channel)
    }
    
    /**
     Get the Socket ID for the connection.
     
     - Returns: The socket id
     */
    open func socketId() -> String {
        return self.connector.socketId()
    }
    
    // Disconnect from the Echo server.
    open func disconnect() {
        self.connector.disconnect();
    }
}
