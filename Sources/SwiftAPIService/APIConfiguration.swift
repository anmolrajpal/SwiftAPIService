//
//  APIConfiguration.swift
//
//
//  Created by Anmol Rajpal on 18/05/24.
//

import Foundation

/// Global Configuration options for API Network calls.
public struct APIConfiguration {
   
   /// The URL Scheme component of the URL. eg: `https`, `http`
   let apiURLScheme:String
   
   /// Hostname of the URL request. e.g. `www.example.com`
   let apiHost:String
   
   /// The port number of the request if exists. This is typically used in localhost environment. e.g. `8081` for a URL: `http://127.0.0.1:8081/api`. The default value is `nil`
   let port:Int?
   
   /// The suffix path of API that will be appended for all requests. e.g. `/api` is the apiSubdirectory for the URL: `https://example.com/api`. The default value is `nil`
   let apiSubdirectory:String?
   
   /// Determines wether to print requests in debug console or not. This is typically useful while in debugging environment. Recommended to set `false` in `production` environment. The default value is `false`
   let isLoggingEnabled: Bool
   
   /**
    APIConfiguration initialiser for setting various components of a URL like scheme, hostname, subdirectory, etc
          
    - Parameters:
      - apiURLScheme: The URL Scheme component of the URL. e.g. `https`, `http`
      - apiHost: Hostname of the URL request. e.g. `www.example.com`
      - port: The port number of the request if exists. This is typically used in localhost environment. e.g. `8081` for a URL: `http://127.0.0.1:8081/api`. The default value is `nil`
      - apiSubdirectory: The suffix path of API that will be appended for all requests. e.g. `/api` is the apiSubdirectory for the URL: `https://example.com/api`. The default value is `nil`
      - isLoggingEnabled: Determines wether to print requests in debug console or not. This is typically useful while in debugging environment. Recommended to set `false` in `production` environment. The default value is `false`
   */
   public init(apiURLScheme: String,
               apiHost: String,
               port: Int? = nil,
               apiSubdirectory: String? = nil,
               isLoggingEnabled: Bool = false) {
      self.apiURLScheme = apiURLScheme
      self.apiHost = apiHost
      self.port = port
      self.apiSubdirectory = apiSubdirectory
      self.isLoggingEnabled = isLoggingEnabled
   }
}
