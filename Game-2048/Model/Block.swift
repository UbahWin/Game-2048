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
    
    private var _value: Int = 0
    var value: Int {
        set {
            _value = newValue
            switch newValue {
            case 0: color = .gray
            case 2: color = Color(hex: 0xfbea00)
            case 4: color = Color(hex: 0xffbb0b)
            case 8: color = Color(hex: 0xf46a02)
            case 16: color = Color(hex: 0xbde200)
            case 32: color = Color(hex: 0x00a149)
            case 64: color = Color(hex: 0x08c8c0)
            case 128: color = Color(hex: 0x015fce)
            case 256: color = Color(hex: 0x7400e9)
            case 512: color = Color(hex: 0xaf01db)
            case 1024: color = Color(hex: 0xff1f61)
            case 2048: color = Color(hex: 0xff1b1c)
            default: color = .gray
            }
        }
        get { return _value }
    }
    var color: Color = .gray
    
    init(value: Int = 0) {
        self.value = value
    }
}
