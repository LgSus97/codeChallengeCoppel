//
//  AppError.swift
//  The Movie DB
//
//  Created by Jesus Loaiza Herrera on 23/04/22.
//

import Foundation

struct AppError {
  static let generic = NSAppError(localizedDescription: ErrorKey.generic, code: ErrorCode.generic)
  
  static let callError = NSAppError(localizedDescription: ErrorKey.generic, code: ErrorCode.generic)
  
  static let callService = NSAppError(localizedDescription: ErrorKey.generic, code: ErrorCode.generic)
  
  static let errorForParseFailed = NSAppError(localizedDescription: ErrorKey.generic, code: ErrorCode.generic)
}
