//
//  APIServer+Protocol.swift
//  SwiftAPIService
//
//  Created by Anmol Rajpal on 09/05/24.
//

import Foundation

public protocol Server<E, Response>: AnyObject {
   
   associatedtype E: APIEndpoint
   associatedtype Response: BaseDecodable
   
   var configuration: APIConfiguration { get }
   
   /// This function is required to initialise the server with given `APIConfiguration` object
   /// - Parameter configuration: The configuration of type `APIConfiguration`
   /// - Returns: Returns the initialised `APIServer` with given Response and Endpoint Type
   static func withConfiguration(_ configuration: APIConfiguration) -> APIServer<E, Response>
   
   /// This function makes a netowrk call with the provided configuration. This function takes `requestBody` argument of type `Data`
   /// - Parameters:
   ///   - endpoint: Endpoint of the network call request
   ///   - params: Parameters to be added at the end of the URL.
   ///   For example: This is our desired URL - ``www.example.com/path?paramKey=paramValue`` then the `params` argument
   ///   will look like `params: ["paramKey": "paramValue"]`
   ///   - requestBody: Resquest HTTP body of type `Data`
   ///   - bearerToken: Bearer token for the network call request header if required
   ///   - headers: Headers to be appended in the request
   ///   - endpointConfiguration: The configuration of type `EndpointConfiguration` where you can set properties like `encoder`, `decoder`, `sessionConfiguration`, `expectedResponseStatus`, etc
   /// - Returns: Returns the expected Response on successful request else throws an error
   func hitEndpoint(_ endpoint: E,
                    params: [String: String]?,
                    requestBody: Data?,
                    bearerToken: String?,
                    headers: [HTTPHeader]?,
                    endpointConfiguration: EndpointConfiguration) async throws -> Response
   
   
   /// This function makes a netowrk call with the provided configuration. This function takes `requestBody` argument of type `Data`
   /// - Parameters:
   ///   - endpoint: Endpoint of the network call request
   ///   - params: Parameters to be added at the end of the URL.
   ///   For example: This is our desired URL - ``www.example.com/path?paramKey=paramValue`` then the `params` argument
   ///   will look like `params: ["paramKey": "paramValue"]`
   ///   - requestBody: Resquest HTTP body of type `RequestBody` which is `Encodable`
   ///   - bearerToken: Bearer token for the network call request header if required
   ///   - headers: Headers to be appended in the request
   ///   - endpointConfiguration: The configuration of type `EndpointConfiguration` where you can set properties like `encoder`, `decoder`, `sessionConfiguration`, `expectedResponseStatus`, etc
   /// - Returns: Returns the expected Response on successful request else throws an error
   func hitEndpoint<RequestBody: Encodable>(_ endpoint: E,
                                            params: [String: String]?,
                                            requestBody: RequestBody?,
                                            bearerToken: String?,
                                            headers: [HTTPHeader]?,
                                            endpointConfiguration: EndpointConfiguration) async throws -> Response
}
