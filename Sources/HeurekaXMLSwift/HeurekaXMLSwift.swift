// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import XMLCoder

public extension HeurekaShop {
    func getAsXMLData() throws -> Data {
        try XMLEncoder().encode(self, withRootKey: "SHOP", header: .init(version: 1, encoding: "utf-8"))
    }
    
    init(fromXMLData xmlData: Data) throws {
        self = try XMLDecoder().decode(Self.self, from: xmlData)
    }
}
