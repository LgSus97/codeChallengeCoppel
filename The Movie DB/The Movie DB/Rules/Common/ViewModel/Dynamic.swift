//
//  Dynamic.swift
//  The Movie DB
//
//  Created by Jesus Loaiza Herrera on 24/04/22.
//

import Foundation

/// Use this class for properties in ViewModels that we expect to change during the View lifecycle.

public class Dynamic<T> {
  public typealias Listener = (T) -> ()
  public var listener: Listener?
  
  public func bind(_ listener: Listener?) {
    self.listener = listener
  }
  

  public var value: T {
    didSet {
      listener?(value)
    }
  }
  
  public init(_ v: T) {
    value = v
  }
}
