//
//  FieldValidationWrapper.swift
//  CombineValigator
//
//  Created by Kapi Zoltán on 2021. 04. 06..
//

import Foundation

/**
 A wrapper to store validation and edit state for fields.
 */
public class FieldValidationWrapper {
   // MARK: - Properties

   public var fieldValidation: FieldValidationProtocol
   public var fieldEditState: FieldEditState = .neverEdited
   public var fieldValidationState: FieldValidationState = .neverValidated
   public var shouldValdiate: Bool

   // MARK: - Initialization

   public init(fieldValidation: FieldValidationProtocol, shouldValdiate: Bool = true) {
       self.fieldValidation = fieldValidation
       self.shouldValdiate = shouldValdiate
   }
}
