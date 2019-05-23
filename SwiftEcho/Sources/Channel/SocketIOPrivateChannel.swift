//
//  SocketIOPrivateChannel.swift
//  LaravelEchoTest
//
//  Created by tuominen-aleksi on 2019/04/03.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation
import SocketIO

class SocketIOPrivateChannel: SocketIoChannel, PrivateChannelType {
    
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
     Trigger client event on the channel.
     
     - Parameters:
        - eventName: Event name
        - data: Data send
     - Returns: The private channel itself
     */
    func whisper(eventName: String, data: [AnyObject]) -> PrivateChannelType {
        self.socket.emit("client event", [
            "channel": self.name,
            "event": "client-" + eventName,
            "data" : data])
        return self
    }
}
