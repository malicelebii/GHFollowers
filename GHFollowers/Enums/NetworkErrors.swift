//
//  NetworkErrors.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 25.09.2024.
//

import Foundation

enum NetworkErrors: String, Error {
    case invalidURL = "You must provide a valid URL"
    case invalidRequest = "The request is not valid"
    case invalidResponse = "The response is not valid"
    case invalidData = "The data is not valid"
    case decodingError = "The data cannot be decoded"
}
