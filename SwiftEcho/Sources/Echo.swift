//
//  Echo.swift
//  LaravelEchoTest
//
//  Created by tuominen-aleksi on 2019/04/03.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation
import SocketIO

class Echo {
    var log: Bool
    var connector: Connector
    var options: [String: Any]
    
    /**
     Create a new class instance.

     - Parameters:
        - options: options
        - log: disable or enable log output
     */
    init(options: [String: Any], log: Bool) {
        self.options = options
        self.log = log
        self.connector = SocketIOConnector(options: self.options, log: self.log);
    }
    /**
     Fired when a connection to the socket is established
     
     - Parameter callback: Normal callback
     */
    func connected(callback: @escaping NormalCallback) {
        return self.on(clientEvent: .connect, callback: callback)
    }
    
    /**
     Listen for an event

     - Parameters:
        - event: Event name
        - callback: Normal callback
     */
    func on(event: String, callback: @escaping NormalCallback) {
        return self.connector.on(event: event, callback: callback)
    }
    
    /**
     Listen for a SocketIO event
     
     - Parameters:
        - event: Event name
        - callback: Normal callback
     */
    func on(clientEvent: SocketClientEvent, callback: @escaping NormalCallback) {
        return self.connector.on(clientEvent: clientEvent, callback: callback)
    }
    
    /**
     Listen for an event on a channel instance.
     
     - Parameters:
        - channel: Channel name
        - event: Event name
        - callback: Normal callback
     - Returns: The listened channel
    */
    func listen(channel: String, event: String, callback: @escaping NormalCallback) -> ChannelType {
        return self.connector.listen(name: channel, event: event, callback: callback);
    }
    
    /**
     Get a channel instance by name.
     
     - Parameter Channel: channel name
     - Returns: The channel
     */
    func channel(channel: String) -> ChannelType {
        return self.connector.channel(name: channel);
    }
    /**
     Get a private channel instance by name.
     
     - Parameter Channel: channel name
     - Returns: The private channel
     */
    func privateChannel(channel: String) -> ChannelType {
        return self.connector.privateChannel(name:channel);
    }
    /**
     Get a presence channel instance by name.
     
     - Parameter Channel: channel name
     - Returns: The private channel
     */
    func join(channel: String) -> PresenceChannelType {
        return self.connector.presenceChannel(name:channel)
    }
    
    /**
     Leave the given channel.
     
     - Parameter channel: The channel name
     */
    func leave(channel: String) {
        self.connector.leave(name: channel)
    }
    
    /**
     Get the Socket ID for the connection.
     
     - Returns: The socket id
     */
    func socketId() -> String {
        return self.connector.socketId()
    }
    
    // Disconnect from the Echo server.
    func disconnect() {
        self.connector.disconnect();
    }
}
