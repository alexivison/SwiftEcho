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

    override func viewDidLoad() {
        super.viewDidLoad()

        let options: [String: Any] = [
            "host":"http://localhost:6001",
            "auth": [
                "headers": [
                    "Authorization": "Bearer " + "Auth token"
                ]
            ]
        ]
        let echo = Echo(options: options)
        
        echo.connected() { (data, ack) in
            print("CONNECTED")
        }
    }
}

