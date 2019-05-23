//
//  EchoClientConfiguration.swift
//  SwiftEcho
//
//  Created by tuominen-aleksi on 2019/05/23.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation

public struct EchoClientConfiguration: ExpressibleByArrayLiteral, Collection {
    
    public typealias Element = EchoClientOption
    
    public typealias Index = Array<EchoClientOption>.Index
    
    public typealias SubSequence = Array<EchoClientOption>.SubSequence
    
    public typealias ArrayLiteralElement = Array<EchoClientOption>.ArrayLiteralElement
    
    private var backingArray = [EchoClientOption]()
    
    public var startIndex: Array<EchoClientOption>.Index {
        return backingArray.startIndex
    }
    
    public var endIndex: Array<EchoClientOption>.Index {
        return backingArray.endIndex
    }
    
    public subscript(position: Index) -> Element {
        get {
            return backingArray[position]
        }
        set {
            backingArray[position] = newValue
        }
    }
    
    public init(arrayLiteral elements: Element...) {
        backingArray = elements
    }
    
    public func index(after i: Index) -> Index {
        return backingArray.index(after: i)
    }
}
