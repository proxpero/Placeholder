
import Argo
import Curry
import Runes

extension User: Decodable {

    public static func decode(_ json: JSON) -> Decoded<User> {
        return curry(self.init)
            <^> json <| "id"
            <*> json <| "name"
            <*> json <| "username"
            <*> json <| "email"
            <*> json <| "address"
            <*> json <| "phone"
            <*> json <| "website"
            <*> json <| "company"
    }

}

extension User.Address: Decodable {

    public static func decode(_ json: JSON) -> Decoded<User.Address> {
        return curry(self.init)
            <^> json <| "street"
            <*> json <| "suite"
            <*> json <| "city"
            <*> json <| "zipcode"
            <*> json <| "geo"
    }

}

extension User.Address.Geo: Decodable {

    public static func decode(_ json: JSON) -> Decoded<User.Address.Geo> {
        return curry(self.init)
            <^> json <| "lat"
            <*> json <| "lng"
    }
    
}

extension User.Company: Decodable {

    public static func decode(_ json: JSON) -> Decoded<User.Company> {
        return curry(self.init)
            <^> json <| "name"
            <*> json <| "catchPhrase"
            <*> json <| "bs"
    }

}

extension Album: Decodable {

    public static func decode(_ json: JSON) -> Decoded<Album> {
        return curry(self.init)
            <^> json <| "userId"
            <*> json <| "id"
            <*> json <| "title"
    }

}

extension Photo: Decodable {

    public static func decode(_ json: JSON) -> Decoded<Photo> {
        return curry(self.init)
            <^> json <| "id"
            <*> json <| "albumId"
            <*> json <| "title"
            <*> json <| "url"
            <*> json <| "thumbnailUrl"
    }

}

