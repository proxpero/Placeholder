
extension User: Equatable {

    public static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.username == rhs.username &&
            lhs.email == rhs.email &&
            lhs.address == rhs.address &&
            lhs.phone == rhs.phone &&
            lhs.website == rhs.website &&
            lhs.company == rhs.company
    }
    
}

extension User.Address: Equatable {

    public static func ==(lhs: User.Address, rhs: User.Address) -> Bool {
        return lhs.street == rhs.street && lhs.suite == rhs.suite && lhs.city == rhs.city && lhs.zipcode == rhs.zipcode && lhs.geo == rhs.geo
    }

}

extension User.Address.Geo: Equatable {

    public static func ==(lhs: User.Address.Geo, rhs: User.Address.Geo) -> Bool {
        return lhs.lat == rhs.lat && lhs.lng == rhs.lng
    }

}

extension User.Company: Equatable {

    public static func ==(lhs: User.Company, rhs: User.Company) -> Bool {
        return lhs.name == rhs.name && lhs.catchPhrase == rhs.catchPhrase && lhs.bs == rhs.bs
    }
    
}

extension Album: Equatable {

    public static func ==(lhs: Album, rhs: Album) -> Bool {
        return lhs.id == rhs.id && lhs.userId == rhs.userId && lhs.title == rhs.title
    }
    
}


extension Photo: Equatable {

    public static func ==(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id && lhs.albumId == rhs.albumId && lhs.title == rhs.title && lhs.url == rhs.url && lhs.thumbnailUrl == rhs.thumbnailUrl
    }
    
}
