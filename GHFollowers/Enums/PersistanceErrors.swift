//
//  PersistanceErrors.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 9.10.2024.
//

import Foundation

enum PersistanceErrors: String, Error {
    case invalidKey = "You must provide a valid key"
    case invalidData = "The data is not valid"
    case decodingError = "The data cannot be decoded"
    case encodingError = "The data cannot be encoded"
    case setError = "The data cannot be set"
}
