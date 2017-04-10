//
//  Model+Resource.swift
//  Placeholder
//
//  Created by Todd Olsen on 4/6/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

import Foundation

private func baseURL(with scheme: String, host: String, path: String? = nil) -> String {
    var result = "\(scheme)://\(host)"
    if let path = path {
        result += "/\(path)"
    }
    return result
}

extension User {

    static var allURLString: String {
        return baseURL(with: "https", host: "jsonplaceholder.typicode.com").appending("/users")
    }

    static var allURL: URL {
        return URL(string: allURLString)!
    }

    static let all = Resource<[User]>(
        url: User.allURL,
        parseJSON: { json  in
            guard let dicts = json as? [JSONDictionary] else { return nil }
            return dicts.flatMap(User.init)
    })

    static func user(withId id: Int) -> Resource<User> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(id)")!
        return Resource<User>(url: url, parseJSON: { json in
            guard let dict = json as? JSONDictionary else { return nil }
            return User(json: dict)
        })
    }

    var albums: Resource<[Album]> {
        let x = baseURL(with: "https", host: "jsonplaceholder.typicode.com") + "/albums?userId=\(id)"
        let url = URL(string: x)!
        return Resource<[Album]>(
            url: url,
            parseJSON: { json in
                guard let dicts = json as? [JSONDictionary] else { return nil }
                return dicts.flatMap(Album.init)
        })
    }

    var posts: Resource<[Post]> {
        let url = URL(string: "jsonplaceholder.typicode.com/posts?userId=\(id)")!
        return Resource<[Post]>(
            url: url,
            parseJSON: { json in
                guard let dicts = json as? [JSONDictionary] else { return nil }
                return dicts.flatMap(Post.init)
        })
    }

    var todos: Resource<[Todo]> {
        let url = URL(string: "jsonplaceholder.typicode.com/todos?userId=\(id)")!
        return Resource<[Todo]>(
            url: url,
            parseJSON: { json in
                guard let dicts = json as? [JSONDictionary] else { return nil }
                return dicts.flatMap(Todo.init)
        })
    }

}

extension Album {

    var photos: Resource<[Photo]> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos?albumId=\(id)")!
        return Resource<[Photo]>(
            url: url,
            parseJSON: { json in
                guard let dicts = json as? [JSONDictionary] else { return nil }
                return dicts.flatMap(Photo.init)
        })
    }
}

extension Post {

    var comments: Resource<[Comment]> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=\(id)")!
        return Resource<[Comment]>(
            url: url,
            parseJSON: { json in
                guard let dicts = json as? [JSONDictionary] else { return nil }
                return dicts.flatMap(Comment.init)
        })
    }
}

import UIKit

extension Photo {

    var thumbnailResource: Resource<UIImage> {
        let url = URL(string: thumbnailUrl)!
        return Resource<UIImage>(url: url, method: .get, parse: { data in
            guard let image = UIImage(data: data) else { return nil }
            return image
        })
    }

    var imageResource: Resource<UIImage> {
        let url = URL(string: self.url)!
        return Resource<UIImage>(url: url, method: .get, parse: { data in
            guard let image = UIImage(data: data) else { return nil }
            return image
        })
    }

}

