
public typealias JSONDictionary = [String: AnyObject]

protocol JSONDecodable {
    init?(json: JSONDictionary)
}

extension User: JSONDecodable {

    public init?(json: JSONDictionary) {
        guard
        let id = json["id"] as? Int,
        let name = json["name"] as? String,
        let username = json["username"] as? String,
        let email = json["email"] as? String,
        let addressDict = json["address"] as? JSONDictionary, let address = Address(json: addressDict),
        let phone = json["phone"] as? String,
        let website = json["website"] as? String,
        let companyDict = json["company"] as? JSONDictionary, let company = Company(json: companyDict)
            else { return nil }

        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }

}

extension User.Address: JSONDecodable {

    public init?(json: JSONDictionary) {

        guard
            let street = json["street"] as? String,
            let suite = json["suite"] as? String,
            let city = json["city"] as? String,
            let zipcode = json["zipcode"] as? String,
            let geoDict = json["geo"] as? JSONDictionary, let geo = Geo(json: geoDict)
            else { return nil }
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }

}

extension User.Address.Geo: JSONDecodable {

    public init?(json: JSONDictionary) {
        guard let lat = json["lat"] as? String, let lng = json["lng"] as? String else { return nil }
        self.lat = lat
        self.lng = lng
    }

}

extension User.Company: JSONDecodable {

    public init?(json: JSONDictionary) {
        guard let name = json["name"] as? String,
            let catchPhrase = json["catchPhrase"] as? String,
            let bs = json["bs"] as? String
            else { return nil }
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs 
    }

}
