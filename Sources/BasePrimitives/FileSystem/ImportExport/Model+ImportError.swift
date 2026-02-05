//
//  Model+ImportError.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/7/2025.
//

import Foundation

public enum ImportError: Error, CustomStringConvertible {
  case resourceNotFound(String)
  case failedToRead(String)
  case fileExtensionMissing
  case decodingFailed(Error)
  case failedSecurityScopedAccess(String)
  case fileImporterFailure(Error)
  
  public var description: String {
    switch self {
      case .resourceNotFound(let path):
        "Resource not found at path: \(path)"
        
      case .failedToRead(let reason):
        "Failed to read file: \(reason)"
        
      case .fileExtensionMissing:
        "File extension missing. Please specify a valid file type."
        
      case .decodingFailed(let error):
        "Failed to decode data: \(error)"
        
      case .failedSecurityScopedAccess(let url):
        "Failed to access file \(url) using a security-scoped resource."
        
      case .fileImporterFailure(let error):
        "Failed to import file: \(error)"
    }
  }
}
