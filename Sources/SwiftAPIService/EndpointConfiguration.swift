//
//  EndpointConfiguration.swift
//
//
//  Created by Anmol Rajpal on 18/05/24.
//

import Foundation

public struct EndpointConfiguration {
   let expectedResponseStatus: [ResponseStatus]
   let expectData: Bool
   let decoder: JSONDecoder
   let encoder: JSONEncoder
   let sessionConfiguration: URLSessionConfiguration
   
   init(expectedResponseStatus: [ResponseStatus] = [],
        expectData: Bool = true,
        decoder: JSONDecoder = .apiServiceDecoder,
        encoder: JSONEncoder = .apiServiceEncoder,
        sessionConfiguration: URLSessionConfiguration = .defaultConfiguration()) {
      self.expectedResponseStatus = expectedResponseStatus
      self.expectData = expectData
      self.decoder = decoder
      self.encoder = encoder
      self.sessionConfiguration = sessionConfiguration
   }
   
   public static let `default` = EndpointConfiguration()
}

extension URLSessionConfiguration {
   public static func defaultConfiguration(withRequestTimeoutInterval: TimeInterval = 60,
                                           withResourceTimeoutInterval: TimeInterval = 604800) -> URLSessionConfiguration {
      let config = URLSessionConfiguration.default
      config.timeoutIntervalForRequest = withRequestTimeoutInterval
      config.timeoutIntervalForResource = withResourceTimeoutInterval
      return config
   }
}
