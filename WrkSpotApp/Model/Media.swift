//
//  Media.swift
//  WrkSpotApp
//
//  Created by Karthik on 31/05/24.
//

import Foundation

struct Media: Decodable {

    let flag: String
    let emblem: String
    let orthographic: String
}

extension Media {

    static func empty() -> Media {
        return Media(
            flag: "",
            emblem: "",
            orthographic: ""
        )
    }
}
