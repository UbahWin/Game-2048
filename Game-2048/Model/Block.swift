//
//  Block.swift
//  Game-2048
//
//  Created by Иван Вдовин on 07.05.2023.
//

import Foundation
import SwiftUI

class Block: Equatable {
    static func == (lhs: Block, rhs: Block) -> Bool {
        return lhs.color == rhs.color
    }
    
    var sizeValueText: Int = 35
    private let smallText = 25
    private let mediumText = 30
    private let largeText = 35
    private func makeSize(value: Int) -> Int {
        if 0 < value && value <= 64 {
            return largeText
        } else if 64 < value && value <= 512 {
            return mediumText
        }
        return smallText
    }
    
    var color: Color = .gray
    
    private var _value: Int = 0
    var value: Int {
        set {
            _value = newValue
            switch newValue {
            case 0: color = .gray
            case 2: color = Color(hex: 0xE7C697)
            case 4: color = Color(hex: 0xEFA94A)
            case 8: color = Color(hex: 0x5D9B9B)
            case 16: color = Color(hex: 0x77DD77)
            case 32: color = Color(hex: 0xFCE883)
            case 64: color = Color(hex: 0xDCD0FF)
            case 128: color = Color(hex: 0xAFDAFC)
            case 256: color = Color(hex: 0x3EB489)
            case 512: color = Color(hex: 0xFF8C69)
            case 1024: color = Color(hex: 0xFF7514)
            case 2048: color = Color(hex: 0xE4717A)
            default: color = .gray
            }
            sizeValueText = makeSize(value: newValue)
        }
        get { return _value }
    }
    
    init(value: Int = 0) {
        self.value = value
    }
}
