//
//  CountryApiURLRequest.swift
//  WrkSpotApp
//
//  Created by Karthik on 01/06/24.
//

import Foundation
import NetworkKit

enum CountryApiURLRequest: NetworkRequestable {

    case fetchCountries

    var url: URL { URL(string: "https://api.sampleapis.com")! }

    var path: String { "/countries/countries" }

    var httpMethod: HTTPMethod { .get }

    var queryParameter: [String : Any]? { return nil }

    var parameters: Any? { return nil }

    var authorizationType: AuthorizationType { .none }

    var encoding: RequestContentType { .json }
}
