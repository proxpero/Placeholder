//
//  Future.swift
//  Placeholder
//
//  Created by Todd Olsen on 4/10/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

public final class Future<A> {

    var callbacks: [(Result<A>) -> ()] = []

    var cached: Result<A>?

    init(compute: (@escaping (Result<A>) -> ()) -> ()) {
        compute(self.send)
    }

    private func send(_ value: Result<A>) {
        assert(cached == nil)
        cached = value
        for callback in callbacks {
            callback(value)
        }
        callbacks = []
    }

    func onResult(_ callback: @escaping (Result<A>) -> ()) {
        if let value = cached {
            callback(value)
        } else {
            callbacks.append(callback)
        }
    }

    func flatMap<B>(transform: @escaping (A) -> Future<B>) -> Future<B> {
        return Future<B> { completion in
            self.onResult { result in
                switch result {
                case .success(let value):
                    transform(value).onResult(completion)
                case .error(let error):
                    completion(.error(error))
                }
            }
        }
    }
    
}
