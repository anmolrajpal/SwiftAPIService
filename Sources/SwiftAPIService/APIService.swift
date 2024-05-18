//
//  APIService.swift
//  SwiftAPIService
//
//  Created by Anmol Rajpal on 09/05/24.
//

import Foundation

public protocol APIService<E> {
   associatedtype E: APIEndpoint
   
   var configuration: APIConfiguration { get }
 
   static func withConfiguration(_ configuration: APIConfiguration) -> SwiftAPIService<E>
   
   func server<Response: Decodable>(_ response: Response.Type) -> APIServer<E, Response>
}
