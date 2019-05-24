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
    
    private var broadcaster: Broadcaster?
    
    private var config: EchoClientConfiguration
    
    public var socketIOConfig: SocketIOClientConfiguration?
    
    public var pusherConfig: Void?
    
    /**
     Create a new class instance.

     - Parameters:
        - options: options
        - log: disable or enable log output
     */
    public init(config: EchoClientConfiguration) {
        self.config = config
        self.connector = NullConnector()
        self.configure()
    }
    
    /**
     Extract the needed options from EchoClient configuration and
     store them in values
     */
    private func configure() {
        for option in self.config {
            switch option {
            case .broadcaster(let broadcaster):
                self.broadcaster = broadcaster
            default:
                continue
            }
        }
    }
    
    /**
     Connect the socket
     
     - Parameter callback: Normal callback: Called after a connection is established.
     */
    public func connect(_ callback: @escaping NormalCallback) {
        // Check for required values
        guard let broadcaster = self.broadcaster else {
            fatalError("No broadcaster provided. Please make sure to pass a broadcaster as an option.")
        }
        // Init the connector base on the broadcaster
        switch broadcaster {
        case .socketIO:
            self.connector = SocketIOConnector(echoConfig: self.config, config: self.socketIOConfig)
            return self.on(socketIOEvent: .connect, callback)
        case .pusher: // TODO: Pusher implementation
            self.connector = NullConnector()
            return
        }
    }
    
    /**
     Listen for an event

     - Parameters:
        - event: Event name
        - callback: Normal callback
     */
    open func on(_ event: String, callback: @escaping NormalCallback) {
        return self.connector.on(event, callback)
    }
    
    /**
     Listen for a SocketIO event
     
     - Parameters:
        - event: Event name
        - callback: Normal callback
     */
    open func on(socketIOEvent: SocketClientEvent, _ callback: @escaping NormalCallback) {
        guard let socketIOConnector = self.connector as? SocketIOConnector else {
            return
        }
        return socketIOConnector.on(clientEvent: socketIOEvent, callback: callback)
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
        return self.connector.listen(channel: channel, event: event, callback);
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
