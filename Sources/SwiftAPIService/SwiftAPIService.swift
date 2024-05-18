//
//  SwiftAPIService.swift
//  SwiftAPIService
//
//  Created by Anmol Rajpal on 09/05/24.
//

import Foundation

public class SwiftAPIService<E: APIEndpoint>: APIService {
   
   public var configuration: APIConfiguration
   
   private init(configuration: APIConfiguration) {
      self.configuration = configuration
   }
   
   public static func withConfiguration(_ configuration: APIConfiguration) -> SwiftAPIService {
      .init(configuration: configuration)
   }
   
   public func server<Response: Decodable>(_ response: Response.Type) -> APIServer<E, Response> {
      return APIServer<E, Response>.withConfiguration(configuration)
   }
}
