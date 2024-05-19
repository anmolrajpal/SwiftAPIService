//
//  BaseDecodable.swift
//  SwiftAPIService
//
//  Created by Anmol Rajpal on 09/05/24.
//

import Foundation

public protocol BaseDecodable: Decodable {
   var responseStatus: ResponseStatus { get set }
}

public extension BaseDecodable {
   var responseStatus: ResponseStatus {
      get { .unknownResponse }
      set {}
   }
}
