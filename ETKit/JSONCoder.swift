//
//  JSONCoder.swift
//  ETKit
//
//  Created by x on 2021/10/31.
//

import Foundation


extension Encodable {
    func encoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
