struct DefinitionsList: Decodable {
    let list: [Definition]
}

struct Definition: Decodable {
    let word: String
    let definition: String
    let example: String
    let written_on: String
    let author: String
}



//      "author": "Zatarain’s Root Beer Drinker",
//      "defid": 15687506,
//      "written_on": "2021-01-25T07:02:13.234Z",
//      "example": "[Seth] [Putnam]: [FAGGOT]!!!!!!!!! FAGGOT!!!!!!!!! FAGGOT!!!!!!!!!\n\nYou’re
