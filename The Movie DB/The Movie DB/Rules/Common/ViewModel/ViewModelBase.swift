//
//  ViewModelBase.swift
//  The Movie DB
//
//  Created by Jesus Loaiza Herrera on 24/04/22.
//

import Foundation

class ViewModelBase  {
  
  var errorHandle:((_ error:NSAppError?,_ service:String)->Void)?
  
  var requestAnswer: Dynamic<RequestAnswer> =  Dynamic((success: false, request: .undefined, error: nil))
  
  func launchError(_ error:NSAppError?,_ service:String) {
    if self.errorHandle != nil {
      self.errorHandle!(error, "login")
    }
  }
}
