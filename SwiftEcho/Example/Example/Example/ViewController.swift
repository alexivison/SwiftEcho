//
//  ViewController.swift
//  Example
//
//  Created by tuominen-aleksi on 2019/05/17.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import UIKit
import SwiftEcho

class ViewController: UIViewController {
    
    private var echo: EchoClient!
    private let chatId: Int = 123

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let host = "https://host.address.com"
        let auth = [
            "headers": [
                "Authorization": "Bearer " + "token"]]
        
        // Init
        self.echo = EchoClient(config: [
            .broadcaster(.socketIO),
            .host(host),
            .auth(auth)])

        self.echo.connect { (_, _) in
            // Listening a channel
            self.echo.join(channel: "chat.\(self.chatId)")
                .listen("comment.created", { (data, ack) in
                    
                })
            // Private channel
            self.echo.join(privateChannel: "private_chat.\(self.chatId)")
                .listen("comment.created", { (data, ack) in
                    
                })
            // Presence channel
            self.echo.join(presenceChannel: "users.\(self.chatId)")
                .here({ (data, ack) in
                    
                })
                .joining({ (data, ack) in
                    
                })
                .leaving({ (data, ack) in
                    
                })

        }
    }
}

