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
    
    private var echo: Echo!
    private let chatId: Int = 123

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Options
        let options: [String: Any] = [
            "host": "https://host.address.com", // Replace with Your host
            "auth": [
                "headers": [
                    "Authorization": "Bearer " + "token" // If the server uses auth, replace with a valid token
                ]
            ]
        ]
        
        // Init
        self.echo = Echo(options: options)
        self.echo.connected { (data, _) in
            // Default channel & Private channel
            self.echo
                .listen(channel: "chat.\(self.chatId)", event: "comment.created") { (comment, _) in
                    print("RESPONSE: ", comment)
                }.unsubscribe()
            // Presence channel
            self.echo
                .join(channel: "chat.\(self.chatId)")
                .here(callback: { (data, ack) in
                    print("HERE")
                })
                .joining(callback: { (data, ack) in
                    print("Joining")
                })
                .leaving(callback: { (data, ack) in
                    print("Leaving")
                })
        }
    }
}

