//
//  Webservice.swift
//  Placeholder
//
//  Created by Todd Olsen on 4/6/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

import Foundation

extension URLRequest {

    /// Initialize a URLRequest with a `Resource`.
    init<A>(resource: Resource<A>) {
        self.init(url: resource.url)
        self.httpMethod = resource.method.method
        if case .post(let data) = resource.method {
            httpBody = data
        }
    }

}

/// An `Error` type to describe bad states of a `Webservice`.
public enum WebserviceError: Error {
    case notAuthenticated
    case other
}

public final class Webservice {

    // Not yet implemented.
    public var authenticationToken: String?

    /// Initialize a `Webservice`.
    public init() {}

    /// Loads a resource. The completion handler is always called on the main queue.
    public func load<A>(_ resource: Resource<A>) -> Future<A> {
        return Future { completion in
            URLSession.shared.dataTask(with: URLRequest(resource: resource)) { (data, response, _) in
                let result: Result<A>
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                    result = Result.error(WebserviceError.notAuthenticated)
                } else {
                    let parsed = data.flatMap(resource.parse)
                    result = Result(parsed, or: WebserviceError.other)
                }
                DispatchQueue.main.async { completion(result) }
                }.resume()
        }
    }
    
}
