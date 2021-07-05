//
//  FormDataUploader.swift
//  
//
//  Created by Simon Schöpke on 19.06.21.
//

import Foundation

public struct FormDataUploader {
    private static let session = URLSession.shared
    private let formData: FormData
    private let url: URL
    
    public init(formData: FormData, url: URL) {
        self.formData = formData
        self.url = url
    }
    
    private var request: URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = formData.httpHeaderFields
        return urlRequest
    }
    
    let semaphore = DispatchSemaphore(value: 0)
    
    public func upload() {
        let task = Self.session.uploadTask(with: request, from: formData.data) { _, _, _ in
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
}
