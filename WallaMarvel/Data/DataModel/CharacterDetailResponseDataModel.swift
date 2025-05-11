struct CharacterDetailDataContainer: Decodable {
    let character: CharacterDetailDataModel

    enum CodingKeys: String, CodingKey {
        case data
        case characters = "results"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)

        let characters = try data.decode([CharacterDetailDataModel].self, forKey: .characters)
        guard let character = characters.first else {
            throw DecodingError.dataCorruptedError(forKey: CodingKeys.characters, in: data, debugDescription: "No characters found")
        }
        self.character = character
    }
}
