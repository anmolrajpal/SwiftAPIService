//
//  APIServer+URL.swift
//
//
//  Created by Anmol Rajpal on 18/05/24.
//

import Foundation

// MARK: - Creates URL for given endpoint
extension APIServer {
   func constructURL(forEndpoint endpoint: E,
                     withConcatenatingPath pathToJoin:String? = nil,
                     parameters:[String:String]? = nil,
                     with configuration: APIConfiguration) -> URL? {
      var components = URLComponents()
      components.scheme = configuration.apiURLScheme
      components.host = configuration.apiHost
      
      if let port = configuration.port {
         components.port = port
      }
      if let concatenatingPath = pathToJoin {
         components.path = configuration.apiSubdirectory + endpoint.path() + "/\(concatenatingPath)"
      } else {
         components.path = configuration.apiSubdirectory + endpoint.path()
      }
      if let parameters = parameters {
         components.setQueryItems(with: parameters)
      }
      return components.url
   }
}

extension URLComponents {
   mutating func setQueryItems(with parameters: [String: String]) {
      self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
   }
}
