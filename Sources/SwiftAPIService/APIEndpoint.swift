//
//  APIEndpoint.swift
//  SwiftAPIService
//
//  Created by Anmol Rajpal on 09/05/24.
//

import Foundation

public protocol APIEndpoint {
   /**
    Returns the path of a specified Endpoint.
    ### Example Usage ###
    ```
    let endpoint:APIService.Endpoint = .ExampleEndpoint
    let endpointPath:String = endpoint.path()
    print("Endpoint: \(endpoint) and its Endpoint Path: \(endpointPath)")
    ```
    - Returns: The Endpoint Path as a String
    */
   func path() -> String
   
   /**
    Returns the HTTP Method of a specified Endpoint.
    ### Example Usage ###
    ```
    let endpoint:APIService.Endpoint = .ExampleEndpoint
    let endpointMethod:HTTPMethod = endpoint.httpMethod()
    print("Endpoint: \(endpoint) and its Endpoint Method: \(endpointMethod)")
    ```
    - Returns: The Endpoint Method as HTTP Method
    */
   func httpMethod() -> HTTPMethod
   
   /// The timeout interval for fine-grained control over data transfer timeouts.
   /// - Returns: The timeout interval for each endpoint
   func requestTimeoutInterval() -> TimeInterval
}

public extension APIEndpoint {
   
   func requestTimeoutInterval() -> TimeInterval {
      60 /// Default timeout interval is `60`
   }
}
