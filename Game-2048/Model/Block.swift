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
            case 2: color = Color(hex: 0xf2e8c9)
            case 4: color = Color(hex: 0xffe4c4)
            case 8: color = Color(hex: 0xfae7b5)
            case 16: color = Color(hex: 0xffdb8b)
            case 32: color = Color(hex: 0xfce883)
            case 64: color = Color(hex: 0xfddb6d)
            case 128: color = Color(hex: 0xffcf48)
            case 256: color = Color(hex: 0xefa94a)
            case 512: color = Color(hex: 0xffb28b)
            case 1024: color = Color(hex: 0xff8c69)
            case 2048: color = Color(hex: 0xe4717a)
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
