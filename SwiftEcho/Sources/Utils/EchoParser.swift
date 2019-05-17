//
//  DataParser.swift
//  LaravelEchoTest
//
//  Created by tuominen-aleksi on 2019/04/04.
//  Copyright © 2019 tuominen-aleksi. All rights reserved.
//

import Foundation

open class EchoParser {
    
    /**
     Parse the socket.io response data into readable form
     
     - Parameters:
        - data: Response data
        - to: Type to parse into
     - Returns: Object of given type, containing the parsed data
     */
    func parse<T: Codable>(data passedData: [Any], to dataType: T.Type) -> T? {
        do {
            let encodedData = try self.encode(passedData[1])
            let decodedData = try self.decode(dataType, from: encodedData)
            return decodedData
        } catch {
            // TODO: Log error if logger enabled
            return nil
        }
    }
    
    /**
     Encode data into type of Data for decoding

     - Parameter data: The data to be encoded
     - Returns: Encoded data
     - Throws: JSONSerialization error
     */
    private func encode(_ data: Any) throws -> Data {
        do {
            let bytes = try JSONSerialization.data(withJSONObject: data, options: [])
            let jsonData = Data(bytes)
            return jsonData
        } catch let error {
            throw error
        }
    }
    
    /**
     Decode the encoded JSON data into the given type
     
     - Parameters:
        - type: Type to decode into
        - from: the data returned from the encode method
     - Returns: data of given type, containing the decoded data
     - Throws: JSONDecoder error
     */
    private func decode<T: Codable>(_ type: T.Type, from data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch let error {
            throw error
        }
    }
}
