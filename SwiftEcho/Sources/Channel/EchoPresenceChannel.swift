//
//  EchoPresenceChannel.swift
//  LaravelEchoTest
//
//  Created by tuominen-aleksi on 2019/04/03.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation
import SocketIO

protocol PresenceChannel {

    /// Register a callback to be called anytime the member list changes.
    ///
    /// - Parameter callback: callback
    /// - Returns: the presence channel itself
    @discardableResult func here(callback: @escaping NormalCallback) -> PresenceChannel
    
    
    /// Listen for someone joining the channel.
    ///
    /// - Parameter callback: callback
    /// - Returns: the presence channel itself
    @discardableResult func joining(callback: @escaping NormalCallback) -> PresenceChannel
    
    /// Listen for someone leaving the channel.
    ///
    /// - Parameter callback: callback
    /// - Returns: the presence channel itself
    @discardableResult func leaving(callback: @escaping NormalCallback) -> PresenceChannel
    
}
