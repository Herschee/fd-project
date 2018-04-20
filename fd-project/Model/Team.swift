//
//  Team.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/18/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import Foundation

struct TeamResponseData: Decodable {
    var teams: [Team]
}

public struct Team: Decodable {
    
    public var id: Int
    public var name: String
    public var city: String
    public var record: String
    public var full_name: String
    public var abbrev: String
    public var color: String
    
}
