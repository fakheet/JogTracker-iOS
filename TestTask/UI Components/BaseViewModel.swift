//
//  BaseViewModel.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import Foundation

protocol BaseViewModel {
  associatedtype Input
  associatedtype Output
  
  func buildOutputFrom(input: Input) -> Output
}
