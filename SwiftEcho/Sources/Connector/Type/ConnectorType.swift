//
//  Connector.swift
//  LaravelEchoTest
//
//  Created by tuominen-aleksi on 2019/04/03.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation
import SocketIO

protocol ConnectorType {

    // Create a fresh connection.
    func connect()
    
    /**
     Set an event handler
     
     - Parameters:
        - event: Event name
        - callback: Normal callback
     */
    func on(event: String, callback: @escaping NormalCallback)
    
    /**
     Set a socket.io client event handler
     
     - Parameters:
        - event: Socket.io client event
        - callback: Normal Callback
     */
    func on(clientEvent: SocketClientEvent, callback: @escaping NormalCallback)
    
    /**
     Get a channel instance by name.
     
     - Parameter name: Channel name
     - Returns: The channel
     */
    func channel(name: String) -> ChannelType
    
    /**
     Listen an event on a channel
     
     - Parameters:
        - name: Channel name
        - event: Event name
        - callback: Normal callback
     - Returns: The channel
     */
    func listen(name: String, event: String, callback: @escaping NormalCallback) -> ChannelType
    
    /**
     Get a private channel instance by name.
     
     - Parameter name: Private channel name
     - Returns: The private channel
     */
    func privateChannel(name: String) -> PrivateChannelType
    
    /**
     Get a presence channel instance by name.
     
     - Parameter name: Presence channel name
     - Returns: The presence channel
     */
    func presenceChannel(name: String) -> PresenceChannelType
    
    /**
     Leave the given channel.
     
     - Parameter name: Channel name
     */
    func leave(name: String)
    
    /**
     Get the socket id of the connection.
     
     - Returns: The socket id
     */
    func socketId() -> String
    
    
    // Disconnect from the Echo server.
    func disconnect()
}
