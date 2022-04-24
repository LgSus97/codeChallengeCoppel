//
//  Requestable.swift
//  The Movie DB
//
//  Created by Jesus Loaiza Herrera on 24/04/22.
//

import Foundation

// MARK: - API Helpers. Result enumeration
///    Custom response for service closures
///  - success: Success service call
///  - failure: Fail service call with error description
typealias RequestResponse = (Result<Response, NSAppError>) -> Void

typealias RequestAnswer = (success: Bool, request: APIRequests, error:NSAppError?)

// MARK: - Requestable protocol extension
/// Protocol for generic services objects
protocol Requestable {
  /// Returns a NSError from custom Data in body response
  /// - Parameters:
  ///     - from: Data from body response
  func error(from data: Error) -> NSAppError
}

// MARK: - Requestable protocol extension
/// Protocol extension with custom perform method definition

extension Requestable {
  
  func perform(request: NSMutableURLRequest, logResponse: Bool = true, completion: @escaping RequestResponse) {
    
    print(request)
    let dataTask = URLSession.shared.dataTask(with: request as URLRequest) {data , response, error  in

      print("responseData --- ")
      

      guard let response = (response as? HTTPURLResponse)?.statusCode  else {
        print("responseData --- AppError.callService ")
        completion(.failure(AppError.callService))
        return
      }
      
      ///  log response
      if let value = data, logResponse {
        print();print()
        print("== SERVER RESPONSE ==")
        print(request.url ?? ""); print("statusCode: \(response)")
        let dataText = String(decoding: value, as: UTF8.self)
        print(dataText)
        print();print();
      }
            
      
      switch response {
      case 200:
        let sessionResponse = Response(data: data)
        completion(.success(sessionResponse))
      case 400,404:
        #if DEBUG
        debugPrint("    Error: --- \(error?.localizedDescription ?? "\(AppError.callError)")")
        #endif
        completion(.failure(AppError.callError))
      default:
        break
      }
    }
    dataTask.resume()

  }
}


