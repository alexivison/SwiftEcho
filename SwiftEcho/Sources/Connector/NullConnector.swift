//
//  NullConnector.swift
//  SwiftEcho
//
//  Created by tuominen-aleksi on 2019/05/22.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation
import SocketIO

open class NullConnector: ConnectorType {

    private var channels = [String: ChannelType]()

    func connect() {}
    
    func on(_ event: String, _ callback: @escaping NormalCallback) {}
    
    func channel(name: String) -> ChannelType {
        return NullChannel()
    }
    
    func listen(channel: String, event: String, _ callback: @escaping NormalCallback) -> ChannelType {
        return NullChannel()
    }
    
    func privateChannel(name: String) -> PrivateChannelType {
        return NullPrivateChannel()
    }
    
    func presenceChannel(name: String) -> PresenceChannelType {
        return NullPresenceChannel()
    }
    
    func leave(name: String) {}
    
    func socketId() -> String {
        return "fake-socket-id"
    }
    
    func disconnect() {}
}
