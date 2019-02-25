//
//  Page.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 22/02/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation

struct Page: Codable {
    var page:Int?
    var total_results:Int?
    var total_pages:Int?
    var results:[Movie]
}
