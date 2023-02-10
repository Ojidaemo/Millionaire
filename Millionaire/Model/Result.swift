//
//  Result.swift
//  Millionaire
//
//  Created by Лерочка on 10.02.2023.
//

import Foundation

struct Result: Codable{
    var name: String
    var winMoney: String
    
    init(name: String, winMoney: String) {
        self.name = name
        self.winMoney = winMoney
    }
}
