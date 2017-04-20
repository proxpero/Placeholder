//
//  Model+Resource.swift
//  Placeholder
//
//  Created by Todd Olsen on 4/6/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

import Foundation

extension User {

    static let all = Resource<[User]>(
        url: Route.users.all,
        parseJSON: { json  in
            guard let dicts = json as? [JSONDictionary] else { return nil }
            return dicts.flatMap(User.init)
    })

    static func user(withId id: Int) -> Resource<User> {
        return Resource<User>(
            url: Route.users[id],
            parseJSON: { json in
                guard let dict = json as? JSONDictionary else { return nil }
                return User(json: dict)
        })
    }

    var albums: Resource<[Album]> {
        return Resource<[Album]>(
            url: Route.users[id][.albums],
            parseJSON: { json in
                guard let dicts = json as? [JSONDictionary] else { return nil }
                return dicts.flatMap(Album.init)
        })
    }

    var posts: Resource<[Post]> {
        return Resource<[Post]>(
            url: Route.users[id][.posts],
            parseJSON: { json in
                guard let dicts = json as? [JSONDictionary] else { return nil }
                return dicts.flatMap(Post.init)
        })
    }

    var todos: Resource<[Todo]> {
        return Resource<[Todo]>(
            url: Route.users[id][.todos],
            parseJSON: { json in
                guard let dicts = json as? [JSONDictionary] else { return nil }
                return dicts.flatMap(Todo.init)
        })
    }

}

extension Album {

    var photos: Resource<[Photo]> {
        return Resource<[Photo]>(
            url: Route.albums[id][.photos],
            parseJSON: { json in
                guard let dicts = json as? [JSONDictionary] else { return nil }
                return dicts.flatMap(Photo.init)
        })
    }
}

extension Post {

    var comments: Resource<[Comment]> {
        return Resource<[Comment]>(
            url: Route.posts[id][.comments],
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

