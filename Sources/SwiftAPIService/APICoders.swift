//
//  APICoders.swift
//  SwiftAPIService
//
//  Created by Anmol Rajpal on 09/05/24.
//

import Foundation

public extension JSONDecoder {
   static let apiServiceDecoder:JSONDecoder = {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      decoder.dateDecodingStrategy = .multiple
      return decoder
   }()
}

public extension JSONEncoder {
   static let apiServiceEncoder:JSONEncoder = {
      let encoder = JSONEncoder()
      encoder.keyEncodingStrategy = .convertToSnakeCase
      return encoder
   }()
}
