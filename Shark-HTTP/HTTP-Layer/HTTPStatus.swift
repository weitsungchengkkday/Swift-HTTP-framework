//
//  HTTPStatus.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/26.
//

import Foundation

public struct HTTPStatus: Hashable {
    public static let success = HTTPStatus(rawValue: 200)
    public static let create = HTTPStatus(rawValue: 201)
    public static let notFound = HTTPStatus(rawValue: 404)
    public static let serverError = HTTPStatus(rawValue: 500)
    
    public let rawValue: Int
}

