//
//  APIService.swift
//  SwiftAPIService
//
//  Created by Anmol Rajpal on 09/05/24.
//

import Foundation

public protocol APIService<E> {
   associatedtype E: APIEndpoint
   
   /// The global API Configuration for the API Service
   var configuration: APIConfiguration { get }
   
   /// This function is required to instantiate the `SwiftAPIService` instance based on the APIConfiguration and Endpoint structure
   /// - Parameter configuration: The `APIConfiguration` of the API that contains parameters like `hostname`, `httpMethod`, etc
   /// - Returns: Returns the intialised `SwiftAPIService` instance holding the Endpoint structure signature that will be used to create server object.
   static func withConfiguration(_ configuration: APIConfiguration) -> SwiftAPIService<E>
   
   /// Initialises the `APIServer` instance that allows to make a network request
   /// - Parameter response: The response model conforming to `BaseDecodable` protocol
   /// - Returns: Returns the `APIServer` instance used to make a network request
   func server<Response: Decodable>(_ response: Response.Type) -> APIServer<E, Response>
}
