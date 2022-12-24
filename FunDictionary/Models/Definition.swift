import Foundation

// MARK: - Definition
struct Definition: Codable {
    let list: [List]
}

// MARK: - List
struct List: Codable {
    let word, author, definition, writtenOn, example: String

    enum CodingKeys: String, CodingKey {
        case definition, author, word, example
        case writtenOn = "written_on"
    }
}
