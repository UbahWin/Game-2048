//
//  Block.swift
//  Game-2048
//
//  Created by Иван Вдовин on 07.05.2023.
//

import Foundation
import SwiftUI

class Block {
    var value: Int
    var color: Color
    
    init(value: Int = 0, color: Color = .gray) {
        self.value = value
        self.color = color
    }
}
