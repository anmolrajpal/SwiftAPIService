//
//  ResponseStatus.swift
//  SwiftAPIService
//
//  Created by Anmol Rajpal on 09/05/24.
//

import Foundation

public enum ResponseStatus: Codable {
   // 2xx
   case ok,
        created,
        noContent,
        accepted,
        // 4xx
        badRequest,
        unauthorized,
        forbidden,
        notFound,
        methodNotAllowed,
        requestTimeout,
        conflict,
        gone,
        preconditionFailed,
        payloadTooLarge,
        uriTooLong,
        unsupportedMediaType,
        expectationFailed,
        misdirectedRequest,
        unprocessableEntity,
        locked,
        failedDependency,
        tooManyRequests,
        // 5xx
        internalServerError,
        notImplemented,
        badGateway,
        serviceUnavailable,
        // Custom
        unknownResponse
}

extension ResponseStatus: RawRepresentable {
   
   public typealias ResponseStatusValue = Int
   
   public init(rawValue: ResponseStatusValue) {
      switch rawValue {
      // 2xx
      case 200: self = .ok
      case 201: self = .created
      case 202: self = .accepted
      case 204: self = .noContent
      // 4xx
      case 400: self = .badRequest
      case 401: self = .unauthorized
      case 403: self = .forbidden
      case 404: self = .notFound
      case 405: self = .methodNotAllowed
      case 408: self = .requestTimeout
      case 409: self = .conflict
      case 410: self = .gone
      case 412: self = .preconditionFailed
      case 413: self = .payloadTooLarge
      case 414: self = .uriTooLong
      case 415: self = .unsupportedMediaType
      case 417: self = .expectationFailed
      case 421: self = .misdirectedRequest
      case 422: self = .unprocessableEntity
      case 423: self = .locked
      case 424: self = .failedDependency
      case 429: self = .tooManyRequests
      // 5xx
      case 500: self = .internalServerError
      case 501: self = .notImplemented
      case 502: self = .badGateway
      case 503: self = .serviceUnavailable
      default: self = .unknownResponse
      }
   }
   
   public var rawValue: ResponseStatusValue {
      getStatusCode(by: self)
   }
   
   public var stringValue:String {
      String(describing: self)
   }
   
   private func getStatusCode(by status:ResponseStatus) -> Int {
      switch status {
      // 2xx
      case .ok: return 200
      case .created: return 201
      case .accepted: return 202
      case .noContent: return 204
      // 4xx
      case .badRequest: return 400
      case .unauthorized: return 401
      case .forbidden: return 403
      case .notFound: return 404
      case .methodNotAllowed: return 405
      case .requestTimeout: return 408
      case .conflict: return 409
      case .gone: return 410
      case .preconditionFailed: return 412
      case .payloadTooLarge: return 413
      case .uriTooLong: return 414
      case .unsupportedMediaType: return 415
      case .expectationFailed: return 417
      case .misdirectedRequest: return 421
      case .unprocessableEntity: return 422
      case .locked: return 423
      case .failedDependency: return 424
      case .tooManyRequests: return 429
      // 5xx
      case .internalServerError: return 500
      case .notImplemented: return 501
      case .badGateway: return 502
      case .serviceUnavailable: return 503
      // Unknown
      case .unknownResponse: return 0
      }
   }
}
