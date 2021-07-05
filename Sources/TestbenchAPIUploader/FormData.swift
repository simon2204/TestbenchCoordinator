//
//  FormData.swift
//  
//
//  Created by Simon Schöpke on 14.06.21.
//

import Foundation

public struct FormData {
    private static let identification = "TestbenchCoordinatorFormBoundary"
    private static let contentType = ContentType.formData.rawValue
    private static let contentDisposition = "form-data"
    
    private let name: String
    private let boundary: Data
    private var multiPartData: Data
    
    private var endBoundary: Data {
        boundary + "--\r\n"
    }
    
    var httpHeaderFields: [String: String] {
        let contentType = "\(Self.contentType); boundary=\(boundary)"
        return ["Content-Type": contentType]
    }
    
    var data: Data {
        multiPartData + endBoundary
    }
    
    public init(name: String) {
        self.name = name
        self.boundary = Self.createBoundary()
        self.multiPartData = Data()
    }
    
    private static func createBoundary() -> Data {
        let uniqueID = UUID().uuidString
        return "--\(Self.identification)\(uniqueID)".data(using: .utf8)!
    }
    
    public mutating func appendFile(_ file: File) {
        multiPartData.append(partData(for: file))
    }
    
    private func partData(for file: File) -> Data {
        boundary + "\r\n"
        + "Content-Disposition: \(FormData.contentDisposition); "
        + "name=\"\(name)\"; "
        + "filename=\"\(file.name)\"\r\n"
        + "Content-type: \(file.contentType.rawValue)\r\n"
        + "\r\n" + file.content + "\r\n"
    }
}
