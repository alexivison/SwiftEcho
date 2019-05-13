//
//  SocketIOChannel.swift
//  LaravelEchoTest
//
//  Created by tuominen-aleksi on 2019/04/03.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation
import SocketIO

class SocketIoChannel: Channel {
    var socket: SocketIOClient
    var name: String
    var auth: [String: Any]
    var eventFormatter: EventFormatter
    var events : [String: [NormalCallback]]
    
    /**
     Create a new class instance.
     
     - Parameters:
        - socket: The socket instance
        - name: The channel name
        - options: Options for the channel
     */
    init(socket: SocketIOClient, name: String, options: [String: Any]) {
        self.name = name
        self.socket = socket
        self.events = [:]
        
        var namespace = ""
        if let wrapperNamespace = options["namespace"] as? String {
            namespace = wrapperNamespace
        }
        
        self.auth = [:]
        if let wrapperAuth = options["auth"] as? [String: Any] {
            self.auth = wrapperAuth
        }
        
        self.eventFormatter = EventFormatter(namespace: namespace)
        
        super.init(options: options)
        
        self.subscribe()
        self.configureReconnector()
    }
    
    // Subscribe to a Socket.io channel.
    override func subscribe() {
        let data = [["channel": self.name, "auth": self.auth]]
        self.socket.emit("subscribe", with: data)
    }
    
    // Unsubscribe from channel and ubind event callbacks.
    override func unsubscribe() {
        self.unbind()
        let data = [["channel": self.name, "auth": self.auth]]
        self.socket.emit("unsubscribe", with: data)
    }
    
    /**
     Listen for an event on the channel instance.
     
     - Parameters:
        - event: Event name
        - callback: Normal callback
     - Returns: The channel itself
     */
    override func listen(event: String, callback: @escaping NormalCallback) -> ChannelType {
        self.on(event: self.eventFormatter.format(event: event), callback: callback)
        return self
    }
    
    /**
     Bind the channel's socket to an event and store the callback.
     
     - Parameters:
        - event: Event name
        - callback: Normal callback
     */
    func on(event: String, callback: @escaping NormalCallback) {
        func listener(data: [Any], ack: SocketAckEmitter) {
            if let channel = data[0] as? String {
                if(self.name == channel) {
                    callback(data, ack)
                }
            }
        }
        self.socket.on(event, callback: listener)
        self.bind(event: event, callback: listener)
    }
    
    // Attach a 'reconnect' listener and bind the event.
    func configureReconnector() {
        func listener(event: [Any], _ack: SocketAckEmitter) {
            self.subscribe()
        }
        self.socket.on("reconnect", callback: listener)
        self.bind(event: "reconnect", callback: listener)
    }
    
    /**
     Bind the channel's socket to an event and store the callback.
     
     - Parameters:
        - event: Event name
        - callback: Normal callback
     */
    func bind(event: String, callback: @escaping NormalCallback) {
        if(self.events[event] == nil) {
            self.events[event] = []
        }
        self.events[event]!.append(callback)
    }
    
    // Unbind the channel's socket from all stored event callbacks.
    func unbind() {
        for (key, _) in self.events {
            self.events[key] = nil
        }
        self.socket.removeAllHandlers()
    }
}
