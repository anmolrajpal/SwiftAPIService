//
//  APIServer+NetworkCall.swift
//
//
//  Created by Anmol Rajpal on 18/05/24.
//

import Foundation

extension APIServer {
   
   public func hitEndpoint(_ endpoint: E,
                           params: [String: String]? = nil,
                           requestBody: Data? = nil,
                           bearerToken: String? = nil,
                           headers: [HTTPHeader]? = nil,
                           endpointConfiguration: EndpointConfiguration = .default) async throws -> Response {
      
      var defaultHeaders = [HTTPHeader]()
      if requestBody != nil {
         defaultHeaders = [HTTPHeader(key: .contentType, value: .contentType·or·accept·json)]
      }
      guard let url = constructURL(forEndpoint: endpoint, parameters: params, with: configuration) else {
         throw APIError.invalidURL
      }
      var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy)
      request.httpMethod = endpoint.httpMethod().rawValue
      request.timeoutInterval = endpoint.requestTimeoutInterval()
      
      if let bearerToken {
         request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: HTTPHeader.HeaderKey.authorization.rawValue)
      }
      
      if let headers = headers {
         headers.forEach({
            request.setValue($0.value, forHTTPHeaderField: $0.key.rawValue)
         })
      } else if !defaultHeaders.isEmpty {
         defaultHeaders.forEach({
            request.setValue($0.value, forHTTPHeaderField: $0.key.rawValue)
         })
      }
      
      if let requestBody {
         request.httpBody = requestBody
         log(requestBody, isRequestBody: true)
      }
      
      let data: Data
      let response: URLResponse
      do {
         (data, response) = try await URLSession(configuration: endpointConfiguration.sessionConfiguration).data(for: request)
      } catch {
         throw APIError.networkError(error: error)
      }
      
      let responseCode = (response as? HTTPURLResponse)?.statusCode ?? ResponseStatus.unknownResponse.rawValue
      let responseStatus = ResponseStatus(rawValue: responseCode)
      
      let responseMessage = "\n\n\t\t-------- Response: BEGIN --------\n\nResponse Status => \(responseStatus)\nResponse Code => \(responseCode)\nFor URL: \(url)\n\n\t\t---------- Response: END ---------\n\n"
      log(responseMessage)
      
      /// Intercepts the network call by throwing an error if response status doesn't matches the expected response status
      if !endpointConfiguration.expectedResponseStatus.isEmpty {
         guard endpointConfiguration.expectedResponseStatus.contains(responseStatus) else {
            throw APIError.unexpectedResponse(response: responseStatus, data: data)
         }
      }
      
      if endpointConfiguration.expectData {
         guard !data.isEmpty else {
            throw APIError.noData(response: responseStatus)
         }
         log(data)
         do {
            var object = try endpointConfiguration.decoder.decode(Response.self, from: data)
            object.setResponse(responseStatus)
            return object
         } catch let error {
            let message = "JSON Decoding Error: \(error)"
            log(message)
            throw APIError.jsonDecodingError(error: error, data: data)
         }
      } else {
         let customObjectString = "{\"result\":\"success\",\"message\":\"Success. Empty Data or Data not required.\",\"data\":{}}"
         /// Explicit unwrapping because jsonString is static so the result is known and should be decoded to (RecurrentResult) -  type
         var customObject = try! endpointConfiguration.decoder.decode(Response.self, from: customObjectString.data(using: .utf8)!)
         customObject.setResponse(responseStatus)
         return customObject
      }
   }
   
   public func hitEndpoint<RequestBody>(_ endpoint: E,
                                        params: [String: String]? = nil,
                                        requestBody: RequestBody? = nil,
                                        bearerToken: String? = nil,
                                        headers: [HTTPHeader]? = nil,
                                        endpointConfiguration: EndpointConfiguration = .default) async throws -> Response where RequestBody: Encodable {
      
      var defaultHeaders = [HTTPHeader]()
      if requestBody != nil {
         defaultHeaders = [HTTPHeader(key: .contentType, value: .contentType·or·accept·json)]
      }
      guard let url = constructURL(forEndpoint: endpoint, parameters: params, with: configuration) else {
         throw APIError.invalidURL
      }
      var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy)
      request.httpMethod = endpoint.httpMethod().rawValue
      if let bearerToken {
         request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: HTTPHeader.HeaderKey.authorization.rawValue)
      }
      
      if let headers = headers {
         headers.forEach({
            request.setValue($0.value, forHTTPHeaderField: $0.key.rawValue)
         })
      } else if !defaultHeaders.isEmpty {
         defaultHeaders.forEach({
            request.setValue($0.value, forHTTPHeaderField: $0.key.rawValue)
         })
      }
      
      if let requestBody {
         let data:Data
         do {
            data = try endpointConfiguration.encoder.encode(requestBody)
         } catch {
            throw APIError.requestBodyEncodingError(error: error, body: requestBody)
         }
         request.httpBody = data
         log(data, isRequestBody: true)
      }
      
      let data: Data
      let response: URLResponse
      do {
         (data, response) = try await URLSession(configuration: endpointConfiguration.sessionConfiguration).data(for: request)
      } catch {
         throw APIError.networkError(error: error)
      }
      
      let responseCode = (response as? HTTPURLResponse)?.statusCode ?? ResponseStatus.unknownResponse.rawValue
      let responseStatus = ResponseStatus(rawValue: responseCode)
      
      let responseMessage = "\n\n\t\t-------- Response: BEGIN --------\n\nResponse Status => \(responseStatus)\nResponse Code => \(responseCode)\nFor URL: \(url)\n\n\t\t---------- Response: END ---------\n\n"
      log(responseMessage)
      
      /// Intercepts the network call by throwing an error if response status doesn't matches the expected response status
      if !endpointConfiguration.expectedResponseStatus.isEmpty {
         guard endpointConfiguration.expectedResponseStatus.contains(responseStatus) else {
            throw APIError.unexpectedResponse(response: responseStatus, data: data)
         }
      }
      
      if endpointConfiguration.expectData {
         guard !data.isEmpty else {
            throw APIError.noData(response: responseStatus)
         }
         log(data)
         
         do {
            var object = try endpointConfiguration.decoder.decode(Response.self, from: data)
            object.setResponse(responseStatus)
            return object
         } catch let error {
            let message = "JSON Decoding Error: \(error)"
            log(message)
            throw APIError.jsonDecodingError(error: error, data: data)
         }
      } else {
         let customObjectString = "{\"result\":\"success\",\"message\":\"Success. Empty Data or Data not required.\",\"data\":{}}"
         /// Explicit unwrapping because jsonString is static so the result is known and should be decoded to (RecurrentResult) -  type
         var customObject = try! endpointConfiguration.decoder.decode(Response.self, from: customObjectString.data(using: .utf8)!)
         customObject.setResponse(responseStatus)
         return customObject
      }
   }
}

extension APIServer {
   fileprivate func log(_ message: String) {
      if isLoggingEnabled {
         print(message)
      }
   }
   
   fileprivate func log(_ data: Data, isRequestBody: Bool = false) {
      if isLoggingEnabled {
         if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
            let json = String(data: jsonData, encoding: .utf8) {
            let jsonMessage = "\n\n\t\t-------- \(isRequestBody ? "Request" : "Data Response") JSON Body: BEGIN ---------\n\n"+json+"\n\n\t\t-------- \(isRequestBody ? "Request" : "Data Response") JSON Body: END --------\n\n"
            print(jsonMessage)
         } else if let json = String(data: data, encoding: .utf8) {
            let jsonMessage = "\n\n\t\t----------- \(isRequestBody ? "Request" : "Data Response") JSON Body: BEGIN ----------\n\n"+json+"\n\n\t\t-------- \(isRequestBody ? "Request" : "Data Response") JSON Body: END ---------\n\n"
            print(jsonMessage)
         } else {
            print("Unable to convert Data to JSON String")
         }
      }
   }
}
