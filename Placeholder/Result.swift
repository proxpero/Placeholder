//
//  Result.swift
//  Placeholder
//
//  Created by Todd Olsen on 4/7/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

public enum Result<A> {
    case success(A)
    case error(Error)
}

extension Result {
    public init(_ value: A?, or error: Error) {
        if let value = value {
            self = .success(value)
        } else {
            self = .error(error)
        }
    }

    public var value: A? {
        guard case .success(let v) = self else { return nil }
        return v
    }
}
