//
//  EventFormatter.swift
//  LaravelEchoTest
//
//  Created by tuominen-aleksi on 2019/04/03.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation

class EventFormatter {
    private var namespace: String = ""
    
    /**
     Create a new class instance.
     
     - Parameter namespace: Namespce
     */
    init(namespace: String? = "") {
        self.setNamespace(namespace!)
    }
    
    // TODO: Add more info on how the format is done
    /**
     Format the given event name.
     
     - Parameter event: Original event name
     - Returns: Formated event name
     */
    func format(event: String) -> String {
        var e : String = ""
        if (!(event.hasPrefix("\\") || event.hasPrefix("."))) {
            e = self.namespace + "." + event
        } else {
            let index = event.index(event.startIndex, offsetBy: 1)
            return String(event[index...])
        }
        return e.replacingOccurrences(of: ".", with: "\\")
    }
    
    // Set the event namespace.
    func setNamespace(_ value: String? = "") {
        if let value = value {
            self.namespace = value
        }
    }
}
