//
//  NullChannel.swift
//  SwiftEcho
//
//  Created by tuominen-aleksi on 2019/05/22.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation
import SocketIO

class NullChannel: ChannelType {
    
    init() {}

    func listen(_ event: String, _ callback: @escaping NormalCallback) -> ChannelType {
        return self
    }
    
    func notification(_ callback: @escaping NormalCallback) -> ChannelType {
        return self
    }
    
    func listenForWhisper(_ event: String, _ callback: @escaping NormalCallback) -> ChannelType {
        return self
    }
    
    func unsubscribe() {}
    
    func subscribe() {}
}
