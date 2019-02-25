//
//  enum.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 22/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation

enum Response<Result:Codable> {
    case success(Result)
    case error(Error)
}
