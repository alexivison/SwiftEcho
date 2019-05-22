//
//  SocketIOConnector.swift
//  LaravelEchoTest
//
//  Created by tuominen-aleksi on 2019/04/03.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation
import SocketIO

open class SocketIOConnector: ConnectorType {
    private var manager: SocketManager?
    private var socket: SocketIOClient?
    
    // Default connector options.
    private var defaultOptions: [String: Any] = [
        "auth": [
            "headers": []],
        "authEndpoint": "/broadcasting/auth",
        "broadcaster": "socket.io",
        "host": "",
        "key": "",
        "namespace": "App.Events"]

    // Passed connector options.
    private var options: [String: Any]
    
    // All of the subscribed channels.
    private var channels: [String: ChannelType]
    
    /**
     Create a new class instance.
     
     - Parameter options: Custom options
     */
    public init(options: [String: Any]) {
        self.options = options
        self.channels = [:]
        self.setOptions(options: options)
        self.connect()
    }
    
    /**
     Merge the custom options with the defaults.
     
     - Parameter options: Custom options
     */
    open func setOptions(options: [String: Any]) {
        self.options =  self.mergeOptions(options: options)
    }
    
    // Create a fresh Socket.io connection.
    open func connect() {
        if let url = self.options["host"] as? String {
            let nurl: URL! = URL(string: url)
            self.manager = SocketManager(socketURL: nurl, config: [.log(true), .compress, .forceWebsockets(true)])
            self.socket = manager?.defaultSocket
            self.socket?.connect()
        }
    }
    
    /**
     Add other handler type
     
     - Parameters:
        - event: Event name
        - callback: Normal callback
     */
    open func on(_ event: String, callback: @escaping NormalCallback) {
        self.socket!.on(event, callback: callback)
    }
    
    /**
     Add SocketIO handler type
     
     - Parameters:
        - event: Event name
        - callback: Normal callback
     */
    open func on(clientEvent: SocketClientEvent, callback: @escaping NormalCallback) {
        self.socket?.on(clientEvent: clientEvent, callback: callback)
    }
    
    /**
     Listen for an event on a channel instance.
     
     - Parameters:
        - channel: Channel name
        - event: Event name
        - callback: Normal callback
     - Returns: The channel
     */
    open func listen(channel: String, event: String, callback: @escaping NormalCallback) -> ChannelType {
        return self.channel(name: channel).listen(event, callback)
    }
    
    /**
     Get a channel instance by name.
     
     - Parameter name: Channel name
     - Returns: The channel
     */
    open func channel(name: String) -> ChannelType {
        if self.channels[name] == nil {
            let socket: SocketIOClient! = self.socket
            self.channels[name] = SocketIoChannel(
                socket: socket, name: name, options: self.options)
        }
        return self.channels[name]!
    }
    
    /**
     Get a private channel instance by name.
     
     - Parameter name: Private channel name
     - Returns: The private channel
     */
    open func privateChannel(name: String) -> PrivateChannelType {
        if self.channels["private-" + name] == nil {
            let socket: SocketIOClient! = self.socket
            self.channels["private-" + name] = SocketIOPrivateChannel(
                socket: socket, name: "private-" + name, options: self.options)
        }
        return self.channels["private-" + name]! as! PrivateChannelType
    }
    
    /**
     Get a presence channel instance by name.
     
     - Parameter name: Presence channel name
     - Returns: The presence channel
     */
    open func presenceChannel(name: String) -> PresenceChannelType {
        if self.channels["presence-" + name] == nil {
            let socket: SocketIOClient! = self.socket
            self.channels["presence-" + name] = SocketIOPresenceChannel(
                socket: socket, name: "presence-" + name, options: self.options)
        }
        return self.channels["presence-" + name]! as! PresenceChannelType
    }
    
    /**
     Leave the given channel.
     
     - Parameter name: Channel name
     */
    open func leave(name: String) {
        let channels: [String] = [name, "private-" + name, "presence-" + name];
        for name in channels {
            if let c = self.channels[name] {
                c.unsubscribe()
                self.channels[name] = nil
            }
        }
    }
    
    /**
     Get the socket id of the connection.
     
     - Returns: The socket id
     */
    open func socketId() -> String {
        guard let socket = self.socket else {
            return ""
        }
        return socket.sid
    }
    
    // Disconnect from the Echo server.
    open func disconnect() {
        let socket: SocketIOClient! = self.socket
        socket.disconnect()
    }
    
    /**
     Merge options with default
     
     - Parameter options: Custom options
     - Returns: Merged options
     */
    private func mergeOptions(options : [String: Any]) -> [String: Any] {
        var def = self.defaultOptions
        for (k, v) in options {
            def[k] = v
        }
        return def
    }
}

