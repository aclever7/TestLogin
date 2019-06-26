//
//  ObjectModel.swift
//  TestLogin
//
//  Created by Anton C on 25/06/2019.
//  Copyright © 2019 Anton Zdasiuk. All rights reserved.
//

import Foundation

struct Responce : Codable {
    let status : Int
    let data : DetailedData
}

struct DetailedData : Codable {
    let access : String
    let text : String
}
