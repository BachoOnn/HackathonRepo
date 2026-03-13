//
//  Config.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//


import Foundation

public protocol Config {
    var DEBUG: Bool { get }
    var API_BASE_URL: String { get }
}

extension Bundle: Config {
    
    public var DEBUG: Bool {
        object(forInfoDictionaryKey: "DEBUG") as! Bool
    }
    
    public var API_BASE_URL: String {
        object(forInfoDictionaryKey: "API_BASE_URL") as! String
    }
}
