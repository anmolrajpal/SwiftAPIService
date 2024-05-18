//
//  APIServer.swift
//  SwiftAPIService
//
//  Created by Anmol Rajpal on 09/05/24.
//

import Foundation

public class APIServer<E: APIEndpoint, Response:BaseDecodable>: Server {
   
   let isLoggingEnabled: Bool
   public var configuration: APIConfiguration

   private init(configuration: APIConfiguration) {
      self.configuration = configuration
      self.isLoggingEnabled = configuration.isLoggingEnabled
   }
   
   public static func withConfiguration(_ configuration: APIConfiguration) -> APIServer<E, Response> {
      .init(configuration: configuration)
   }
}
