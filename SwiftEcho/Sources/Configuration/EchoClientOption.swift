//
//  EchoClientOption.swift
//  SwiftEcho
//
//  Created by tuominen-aleksi on 2019/05/23.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation

public enum Broadcaster {
    case socketIO
    case pusher
}

public enum EchoClientOption {

    /**
     Authentication parameters. Use this to pass headers.
     */
    case auth([String: Any])
    
    /**
     Authentication endpoint
     */
    case authEndpoint(String)
    
    /**
     Broadcaster type of the client.
     */
    case broadcaster(Broadcaster)
    
    /**
     The server hosting the socket
     */
    case host(String)
    
    /**
     Pusher key
     */
    case key(String)
    
    /**
     Namespace
     */
    case namespace(String)
}
