//
//  BaseModel.swift
//  Softcom
//
//  Created by Olar's Mac on 5/18/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation

struct BaseModel: Codable {
    let id: String
    let name: String
    let pages: [PagesModel]
}

struct PagesModel: Codable {
    let label: String
    let sections: [SectionsModel]
}

struct SectionsModel: Codable {
    let label: String
    let elements: [ElementsModel]
}

struct ElementsModel: Codable {
    let type: String?
    let label: String?
    let file: String?
    let keyboard: String?
    let formattedNumeric: String?
    let isMandatory: Bool?
    let unique_id: String?
    let rules: [RulesModel]?
    
//    enum ElementsModelCodingKeys: String, CodingKey {
//        case type
//        case label
//        case file
//        case keyboard
//        case formattedNumeric
//        case isMandatory
//        case uniqueId = "unique_id"
////        case rules
//
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: ElementsModelCodingKeys.self)
//        type = try container.decode(String.self, forKey: .type)
//        label = try container.decode(String.self, forKey: .label)
//        file = try container.decode(String.self, forKey: .file)
//        keyboard = try container.decode(String.self, forKey: .keyboard)
//        formattedNumeric = try container.decode(String.self, forKey: .formattedNumeric)
//        isMandatory = try container.decode(Bool.self, forKey: .isMandatory)
//        uniqueId = try container.decode(String.self, forKey: .uniqueId)
////        rules = try container.decode([String].self, forKey: .rules)
//
//    }
    
}


struct RulesModel: Codable {
    let condition: String?
    let value: String?
    let action: String?
    let otherwise: String?
    let targets: [String]?
}
