//
//  HTTPMethod.swift
//
//
//  Created by Anmol Rajpal on 18/05/24.
//

import Foundation

public enum HTTPMethod {
   case get, post, put, delete, patch, head, trace, options, connect
   
   var rawValue:String {
      String(describing: self).uppercased()
   }
}
