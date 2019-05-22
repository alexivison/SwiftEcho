//
//  NullPresenceChannel.swift
//  SwiftEcho
//
//  Created by tuominen-aleksi on 2019/05/22.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation
import SocketIO

class NullPresenceChannel: NullChannel, PresenceChannelType {
    
    override init() {}
    
    func here(callback: @escaping NormalCallback) -> PresenceChannelType {
        return self
    }
    
    func joining(callback: @escaping NormalCallback) -> PresenceChannelType {
        return self
    }
    
    func leaving(callback: @escaping NormalCallback) -> PresenceChannelType {
        return self
    }
}
