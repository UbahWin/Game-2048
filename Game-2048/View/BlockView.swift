//
//  BlockView.swift
//  Game-2048
//
//  Created by Иван Вдовин on 07.05.2023.
//

import SwiftUI

struct BlockView: View {
    var block: Block
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(block.color)
                .frame(width: 80, height: 80)
            if block.value != 0 {
                Text("\(block.value)")
                    .font(.system(size: 40))
            }
        }
    }
}

struct BlockView_Previews: PreviewProvider {
    static var previews: some View {
//        BlockView(block: Block()) // empty for preview
        BlockView(block: Block(value: 2, color: .orange)) // not empty for preview
    }
}
