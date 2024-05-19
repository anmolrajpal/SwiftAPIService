//
//  APIError.swift
//  SwiftAPIService
//
//  Created by Anmol Rajpal on 09/05/24.
//

import Foundation

public enum APIError: Error {
   
   public static let commonErrorDescription = "Something went wrong. Please try again later."
   
   case cancelled
   case invalidURL
   case noResponse
   case unexpectedResponse(response:ResponseStatus, data:Data? = nil)
   case noData(response:ResponseStatus)
   case requestBodyEncodingError(error: Error, body: Encodable)
   case jsonDecodingError(error: Error, data:Data)
   case networkError(error: Error)
   case resultError(message: String)
}

extension APIError: Equatable {
   var value: String? {
      return String(describing: self).components(separatedBy: "(").first
   }
   
   public static func == (lhs: APIError, rhs: APIError) -> Bool {
      lhs.value == rhs.value
   }
}

extension APIError: LocalizedError {
   
   public var localizedDescription: String {
      switch self {
         case .cancelled: return "Network operation cancelled by the user"
         case .invalidURL: return "Error constructing URL"
         case .noResponse: return "No Response from Server"
         case .unexpectedResponse(let response, _): return "\(response) | Code: \(response.rawValue))"
         case let .noData(response): return "No Data: \(response) | Code: \(response.rawValue))"
         case let .networkError(error): return "Network Error: \(error.localizedDescription)"
         case let .requestBodyEncodingError(error, body): return "Failed to Encode request body: \(body). Error: \(error.localizedDescription)"
         case let .jsonDecodingError(error, _): return "Failed to Decode data. Error: \(error.localizedDescription)"
         case let .resultError(message): return message
      }
   }
   
   public var publicDescription: String {
      switch self {
         case .cancelled,
               .noResponse,
               .noData,
               .networkError: return APIError.commonErrorDescription
         case .invalidURL: return "Application Error. Please report this bug."
         case .unexpectedResponse(response: _, data: let data):
            if let data = data,
               let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let message = jsonObject["message"] as? String {
               return message
            } else {
               return APIError.commonErrorDescription
            }
         case .resultError(let message): return message
         case .jsonDecodingError, .requestBodyEncodingError:
            // Since this is response decoding error, it should be reported to developers if not handled. Even if we get success from API
            /*
             if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
             let message = jsonObject["message"] as? String {
             return message
             } else {
             return "Service Error. Please report this bug."
             }
             */
            return "Service Error. Please report this bug."
      }
   }
}
