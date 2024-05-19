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
      var path = configuration.apiSubdirectory ?? ""
      if let concatenatingPath = pathToJoin {
         path += endpoint.path() + "/\(concatenatingPath)"
      } else {
         path += endpoint.path()
      }
      components.path = path
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
