//
//  Cache.swift
//  Placeholder
//
//  Created by Todd Olsen on 4/7/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

import Foundation

/// A class to manage caching `Resource`s.
public final class Cache {

    // The private implementation of the cached memory.
    private var storage: FileStorage

    /// Initialize with a `FileStorage` object. Default is `FileStorage()`
    public init(storage: FileStorage = FileStorage()) {
        self.storage = storage
    }

    /// Try to load a resource of type A from the cache,
    /// return `nil` if it is not there. Only resources
    /// with a `method` value of `.get` are supported.
    public func load<A>(_ resource: Resource<A>) -> A? {
        guard case .get = resource.method else { return nil }
        let data = storage[resource.cacheKey]
        return data.flatMap(resource.parse)
    }

    /// Place the `data` of `resource` in the cache.
    public func save<A>(_ data: Data, for resource: Resource<A>) {
        guard case .get = resource.method else { return }
        storage[resource.cacheKey] = data
    }

}

extension Resource {

    /// A unique key to act as an address for the resource in a cache.
    var cacheKey: String {
        return "cache." + url.absoluteString.md5
    }

}
