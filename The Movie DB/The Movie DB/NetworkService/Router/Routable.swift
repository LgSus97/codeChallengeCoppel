//
//  Routable.swift
//  The Movie DB
//
//  Created by Jesus Loaiza Herrera on 23/04/22.
//

import Foundation

protocol Router {
  ///The body can be any type
  var baseURL : String { get }
  var httpProtocol : HttpProtocol { get }
  var path : String { get }
  var method : HttpMethod { get }
  var body : [String: Any]? { get }
  var bodystr : String? { get }
  var authField: String? { get }
}

protocol Routable: Router { }

extension Routable {
  //Note:- Default values
  

  
  var authField: String? {
    return nil
  }
  
  var body : [String: Any]? {
    return nil
  }
  var bodystr : String? {
    return nil
  }
  
  var baseURL : String {
    return TargetEnvironment.appEndpoint
  }
  
  func asURLRequest() throws -> NSMutableURLRequest {
    
    var request:NSMutableURLRequest = NSMutableURLRequest()

    
    //Protocol
    let httpProtocol = self.httpProtocol.rawValue
    
    //URL
    let urlString = httpProtocol + baseURL
    let urlRequest =  URL(string: urlString)!
    request = NSMutableURLRequest(url: urlRequest)

    
    //Request Method
    request.httpMethod = method.rawValue
    request.timeoutInterval = TimeInterval(300)

    //Headers
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    
    //Auths
    if let auth = authField {
      request.addValue(auth, forHTTPHeaderField: "Authorization")
    }
    
    //Params in body
    
    if let body = self.body, let bodyObject = try? JSONSerialization.data(withJSONObject: body, options: []) {
      request.httpBody = bodyObject
      //Print params
      if let text = String(data: bodyObject, encoding: String.Encoding.utf8) as String? {
        #if DEBUG
        debugPrint("param: \(text)")
        #endif
      }
    }
    
    return request
  }
}

