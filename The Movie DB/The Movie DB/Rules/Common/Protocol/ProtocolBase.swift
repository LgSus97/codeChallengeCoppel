//
//  ProtocolBase.swift
//  The Movie DB
//
//  Created by Jesus Loaiza Herrera on 24/04/22.
//

import Foundation

protocol  ProtocolBase : AnyObject {
  
  var errorHandle:((_ error:NSAppError?,_ service:String)->Void)? { set  get }
  
  var requestAnswer: Dynamic<RequestAnswer> { get set }
  
  func launchError(_ error:NSAppError?,_ service:String)
}
