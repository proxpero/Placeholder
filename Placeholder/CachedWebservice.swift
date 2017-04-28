//
//  CachedWebservice.swift
//  Placeholder
//
//  Created by Todd Olsen on 4/7/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

import Foundation

/// A class to manage the interaction bwtween a `Webservice` and a `cache`.
public final class CachedWebservice {

    static let shared = CachedWebservice(Webservice.shared)

    private let webservice: Webservice
    private let cache: Cache

    /// Initialize `CachedWebservice` with a `Webservice` and a `Cache`
    public init(_ webservice: Webservice, cache: Cache = Cache()) {
        self.webservice = webservice
        self.cache = cache
    }

    /// Load a resource, if the response has been cached, wrap it in a `Future`,
    /// then return the future. Otherwise, load the response from the network, 
    /// cache it, wrap it in a `Future`, then return the future.
    public func load<A>(_ resource: Resource<A>) -> Future<A> {

        if let result = cache.load(resource) {
            return Future { completion in
                completion(.success(result))
            }
        }
        
        let dataResource = Resource<Data>(url: resource.url, method: resource.method, parse: { $0 })

        return Future { completion in
            webservice.load(dataResource).onResult({ result in
                switch result {
                case .success(let data):
                    self.cache.save(data, for: resource)
                    completion(Result(resource.parse(data), or: WebserviceError.other))
                case .error(let error):
                    completion(.error(error))
                }
            })
        }
    }

}
