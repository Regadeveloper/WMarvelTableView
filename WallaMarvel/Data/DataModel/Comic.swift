struct Comic: Decodable {
    let items: [ComicItem]
}

struct ComicItem: Decodable {
    let resourceURI: String
    let name: String
}
