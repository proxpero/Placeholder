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

public protocol NetworkEngine {
    typealias Handler = (Data?, URLResponse?, Error?) -> ()
    func request<A>(resource: Resource<A>, handler: @escaping Handler)
}

extension URLSession: NetworkEngine {
    public typealias Handler = NetworkEngine.Handler

    public func request<A>(resource: Resource<A>, handler: @escaping Handler) {
        let task = dataTask(with: URLRequest(resource: resource), completionHandler: handler)
        task.resume()
    }

}

public final class Webservice {

    static let shared = Webservice()

    // The `NetworkEngine` to use for making URLRequests, probably the 
    // URLSession.shared singleton, but possibly a mock during testing.
    private let engine: NetworkEngine

    /// Initialize a `Webservice` with an optional `NetworkEngine` which defaults
    /// to `URLSession.shared`. Using an alternate engine is useful for testing.
    public init(engine: NetworkEngine = URLSession.shared) {
        self.engine = engine
    }

    /// Loads a resource. The completion handler is always called on the main queue.
    ///
    /// - Parameter resource: A `Resource` of `A`
    /// - Returns: A `Future` of `A`
    public func load<A>(_ resource: Resource<A>) -> Future<A> {
        return Future { completion in
            engine.request(resource: resource) { (data, response, _) in
                let result: Result<A>
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                    result = Result.error(WebserviceError.notAuthenticated)
                } else {
                    let parsed = data.flatMap(resource.parse)
                    result = Result(parsed, or: WebserviceError.other)
                }
                DispatchQueue.main.async { completion(result) }
            }
        }
    }

}
