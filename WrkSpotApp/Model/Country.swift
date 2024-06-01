//
//  Country.swift
//  WrkSpotApp
//
//  Created by Karthik on 31/05/24.
//

import Foundation

struct Country: Identifiable, Equatable, Decodable {
    
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.id == rhs.id
    }

    var id: Int
    let name: String
    let abbreviation: String
    let capital: String
    let currency: String
    let population: Int
    let phone: String
    var media: Media

    init(
        id: Int,
        name: String,
        abbreviation: String,
        capital: String,
        currency: String,
        population: Int,
        phone: String,
        media: Media
    ) {
        self.id = id
        self.name = name
        self.abbreviation = abbreviation
        self.capital = capital
        self.currency = currency
        self.population = population
        self.phone = phone
        self.media = media
    }

    enum CodingKeys: CodingKey {
        case id
        case name
        case abbreviation
        case capital
        case currency
        case population
        case phone
        case media
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.abbreviation = try container.decode(String.self, forKey: .abbreviation)
        self.capital = try container.decode(String.self, forKey: .capital)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.population = try container.decodeIfPresent(Int.self, forKey: .population) ?? 0
        self.phone = try container.decode(String.self, forKey: .phone)
        self.media = try container.decode(Media.self, forKey: .media)
    }
}

// MARK: - Stubs
extension Country {

    /// - NOTE: Population more than 10 million
    static func bangladesh() -> Country {
        return Country(
            id: 1,
            name: "Bangladesh",
            abbreviation: "BD",
            capital: "Dhaka",
            currency: "BDT",
            population: 162951560,
            phone: "880",
            media: Media(
                flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Flag_of_Bangladesh.svg/1280px-Flag_of_Bangladesh.svg.png",
                emblem: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/National_emblem_of_Bangladesh.svg/1280px-National_emblem_of_Bangladesh.svg.png",
                orthographic: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Bangladesh_%28orthographic_projection%29.svg/1280px-Bangladesh_(orthographic_projection).svg.png"
            )
        )
    }

    /// - NOTE: Population more than 10 million
    static func belgium() -> Country {
        return Country(
            id: 2,
            name: "Belgium",
            abbreviation: "BE",
            capital: "Brussels",
            currency: "EUR",
            population: 11348159,
            phone: "32",
            media: Media(
                flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Flag_of_Belgium.svg/1182px-Flag_of_Belgium.svg.png",
                emblem: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Great_coat_of_arms_of_Belgium.svg/1280px-Great_coat_of_arms_of_Belgium.svg.png",
                orthographic: ""
            )
        )
    }

    /// - NOTE: Population less than a million<##>
    static func kiribati() -> Country {
        return Country(
            id: 3,
            name: "Kiribati",
            abbreviation: "BE",
            capital: "Tarawa",
            currency: "AUD",
            population: 114395,
            phone: "686",
            media: Media.empty()
        )
    }

    /// - NOTE: Population less than 5 million
    static func bosnia() -> Country {
        Country(
            id: 4,
            name: "Bosnia and Herzegovina",
            abbreviation: "BA",
            capital: "Sarajevo",
            currency: "BAM",
            population: 3516816,
            phone: "387",
            media: Media.empty()
        )
    }

    /// - NOTE: Population less than 10 million
    static func bulgaria() -> Country {
        Country(
            id: 5,
            name: "Bulgaria",
            abbreviation: "BG",
            capital: "Sofia",
            currency: "BGN",
            population: 7127822,
            phone: "359",
            media: Media.empty()
        )
    }
}
