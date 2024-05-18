//
//  JSONDecoder+Date.swift
//
//
//  Created by Anmol Rajpal on 18/05/24.
//

import Foundation

extension JSONDecoder.DateDecodingStrategy {
   static let multiple = custom {
      let container = try $0.singleValueContainer()
      
      if let string = try? container.decode(String.self) {
         if let date = DateFormatter.iso8601withFractionalSeconds.date(from: string) ??
               DateFormatter.iso8601.date(from: string) ??
               DateFormatter.standard.date(from: string) {
            return date
         }
         throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
      } else if let secondsOrMilliseconds = try? container.decode(Int.self) {
         if let date = Date(fromSecondsOrMilliSeconds: secondsOrMilliseconds) {
            return date
         }
         throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid timestamp in seconds/milliseconds: \(secondsOrMilliseconds)")
      } else if let secondsOrMilliseconds = try? container.decode(Double.self) {
         return Date(timeIntervalSince1970: secondsOrMilliseconds)
      } else {
         throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date datatype")
      }
   }
}

extension DateFormatter {
   static let iso8601withFractionalSeconds: ISO8601DateFormatter = {
      let formatter = ISO8601DateFormatter()
      formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
      return formatter
   }()
   static let iso8601: ISO8601DateFormatter = {
      let formatter = ISO8601DateFormatter()
      formatter.formatOptions = [.withInternetDateTime]
      return formatter
   }()
}

extension DateFormatter {
   static let standardT: DateFormatter = {
      var dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
      return dateFormatter
   }()
   
   static let standard: DateFormatter = {
      var dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
      return dateFormatter
   }()
}

extension Date {
   /// This initializer returns the Date object depending on the parameter which maybe is seconds or milliseconds.
   /// - Note: This  function is only valid for next `267` years till `Saturday, 20 November 2286 17:46:39.999`
   /// - Parameter value: Parameter value must be either `seconds` or `milliseconds` | `10 digits`  or `13 digits` respectively.
   /// - Returns: `Date` object calculted from timeInterval passed since 1970 or milliSeconds passed since 1970
   init?(fromSecondsOrMilliSeconds value:Int) {
      let count = value.digitsCount
      switch count {
      case 11...13:
         let suffix = 10 ~^ (13 - count)
         let sanitisedDate = Int64(value * suffix)
         self = Date(milliSecondsSince1970: sanitisedDate)
      case 6...10:
         let suffix = 10 ~^ (10 - count)
         let sanitizedDate = TimeInterval(value * suffix)
         self = Date(timeIntervalSince1970: sanitizedDate)
      default:
         return nil
      }
   }
   
   /// Initializes the `Date` object from given milliseconds since 1970 (the epoch time)
   /// - Parameter milliSecondsSince1970: This parameter takes milliseconds which must be of 13 digits till next `267 years` from the time of coding this function.
   init(milliSecondsSince1970 value: Int64) {
      self = Date(timeIntervalSince1970: TimeInterval(value / 1000))
      self.addTimeInterval(TimeInterval(Double(value % 1000) / 1000 ))
   }
}

extension Numeric where Self: LosslessStringConvertible {
   /// Returns an array of integer digits from called integer.
   var digits: [Int] { string.digits }
   
   /// Returns count of array of integer digits from called integer.
   var digitsCount:Int { string.digits.count }
}

extension StringProtocol  {
   /// Returns an array of integer digits from called string integer.
   var digits: [Int] { compactMap(\.wholeNumberValue) }
}
extension LosslessStringConvertible {
   var string: String { .init(self) }
}
