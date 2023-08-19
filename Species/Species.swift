//
//  Species.swift
//  Species
//
//  Created by Bob Witmer on 2023-08-18.
//

import Foundation

struct Species: Identifiable, Codable {
    let id: String = UUID().uuidString

    var name: String = ""
    var classification: String = ""
    var designation: String = ""
    var average_height: String = ""
    var skin_colors: String = ""
    var hair_colors: String = ""
    var eye_colors: String = ""
    var average_lifespan: String = ""
    var language: String = ""
    var url: String = ""

    enum CodingKeys: CodingKey {
        case name, classification, designation, average_height, skin_colors, hair_colors, eye_colors, average_lifespan, language, url
    }
}
