//
//  HttpMethod.swift
//  Placeholder
//
//  Created by Todd Olsen on 4/6/17.
//  Copyright © 2017 proxpero. All rights reserved.
//


public enum HttpMethod<Body> {
    case get
    case post(Body)
}

extension HttpMethod {
    public var method: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}

extension HttpMethod {

    public func map<A>(transform: (Body) -> A) -> HttpMethod<A> {
        switch self {
        case .get: return .get
        case .post(let body):
            return .post(transform(body))
        }
    }

}