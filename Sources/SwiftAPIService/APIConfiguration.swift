//
//  APIConfiguration.swift
//
//
//  Created by Anmol Rajpal on 18/05/24.
//

import Foundation

/// Global Configuration options for API Network calls.
public struct APIConfiguration {
   let apiURLScheme:String
   let apiHost:String
   let port:Int?
   let apiSubdirectory:String
   let isLoggingEnabled: Bool
   
   public init(apiURLScheme: String,
               apiHost: String,
               port: Int?,
               apiSubdirectory: String,
               isLoggingEnabled: Bool = false) {
      self.apiURLScheme = apiURLScheme
      self.apiHost = apiHost
      self.port = port
      self.apiSubdirectory = apiSubdirectory
      self.isLoggingEnabled = isLoggingEnabled
   }
}
