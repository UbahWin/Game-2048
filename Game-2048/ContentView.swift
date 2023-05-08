//
//  ContentView.swift
//  Game-2048
//
//  Created by Иван Вдовин on 07.05.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var game = Game()
    
    var body: some View {
        
        VStack {
            Text("2048")
                .font(.system(size: 80))
            
            VStack(spacing: 5) {
                ForEach(0..<4, id: \.self) { row in
                    HStack(spacing: 5) {
                        ForEach(0..<4, id: \.self) { col in
                            ZStack {
                                Rectangle()
                                    .fill(game.board[row][col].color)
                                    .frame(width: 80, height: 80)
                                if game.board[row][col].value != 0 {
                                    Text("\(game.board[row][col].value)")
                                        .font(.system(size: 40))
                                }
                            }
                        }
                    }
                }
            }
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onEnded { value in
                    let dx = value.translation.width
                    let dy = value.translation.height
                    if abs(dx) > abs(dy) {
                        if dx > 0 {
                            game.shiftBlocks(to: .right)
                            print("right")
                        } else {
                            game.shiftBlocks(to: .left)
                            print("left")
                        }
                    } else {
                        if dy > 0 {
                            game.shiftBlocks(to: .down)
                            print("down")
                        } else {
                            game.shiftBlocks(to: .up)
                            print("up")
                        }
                    }
                })
            .padding()
            
            Button(
                action: { game.resetBoard() },
                label: { Image(systemName: "arrow.clockwise") }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
