//
//  HTTPHeader.swift
//  SwiftAPIService
//
//  Created by Anmol Rajpal on 09/05/24.
//

import Foundation

public struct HTTPHeader {
   let key:HeaderKey
   let value:String
   
   public enum HeaderKey:String {
      case authorization = "Authorization"
      case cacheControl = "Cache-Control"
      case postmanToken = "Postman-Token"
      case xRequestedWith = "X-Requested-With"
      case contentType = "Content-Type"
      case contentLength = "Content-Length"
      case host = "Host"
      case userAgent = "User-Agent"
      case accept = "Accept"
      case acceptEncoding = "Accept-Encoding"
      case connection = "Connection"
   }
   
   public enum HeaderValue:String {
      case contentType·or·accept·json = "application/json"
      case contentType·or·accept·xml = "application/xml"
      case contentType·urlEncoded = "application/x-www-form-urlencoded"
      case contentType·image·jpeg = "image/jpeg"
      case accept·jsonFormatted = "application/json;indent=2"
   }
}

extension HTTPHeader {
   public init(key: HeaderKey, value: HeaderValue) {
      self.key = key
      self.value = value.rawValue
   }
}
