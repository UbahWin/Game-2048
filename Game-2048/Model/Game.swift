//
//  Game.swift
//  Game-2048
//
//  Created by Иван Вдовин on 07.05.2023.
//

import Foundation
import SwiftUI

class Game: ObservableObject {
    @Published var board = [[Block]]()
    let emptyBlock: Block = Block()
    var sizeBoard: Int = 4
    @Published var gameOver: Bool = false
    @Published var message: String = ""
    var isMoved = false
    
    init() {
        resetBoard()
    }
    
    // Функция для генерации нового блока
    func generateNewBlock() {
        // Находим все свободные блоки
        var emptyBlocks = [(Int, Int)]()
        for i in 0..<4 {
            for j in 0..<4 {
                if board[i][j] == emptyBlock {
                    emptyBlocks.append((i, j)) // Координаты пустых ячеек
                }
            }
        }
        // Если есть свободные блоки, выбираем случайный и создаем новый блок
        if !emptyBlocks.isEmpty {
            let randomIndex = Int(arc4random_uniform(UInt32(emptyBlocks.count)))
            let (i, j) = emptyBlocks[randomIndex]
            let randValue = Int.random(in: 1...2) * 2
            board[i][j] = Block(value: randValue)
        } else {
            gameOver = true
            message = "Вы проиграли"
        }
    }

    // Функция для проверки достижения числа 2048
    func checkWin() {
        for i in 0..<sizeBoard {
            for j in 0..<sizeBoard {
                if board[i][j].value == 2048 {
                    gameOver = true
                    message = "Вы выиграли!!!"
                }
            }
        }
    }
    
    // Обновляем поле
    func resetBoard() {
        var newBoard = [[Block]]()
        for _ in 0..<sizeBoard {
            var row = [Block]()
            
            for _ in 0..<sizeBoard {
                row.append(Block())
            }
            newBoard.append(row)
        }
        board = newBoard
        generateNewBlock()
        gameOver = false
        message = ""
    }
    
    func blockEmpty(row: Int, col: Int) -> Bool {
        return board[row][col] == emptyBlock
    }
    
    func flip() {
        board = board.map { $0.reversed() }
    }

    func rotate() {
        var newBoard = board
        for row in 0..<board.count {
            for column in 0..<board[row].count {
                newBoard[row][column] = board[column][row];
            }
        }
        board = newBoard
    }
    
    private func operateRows() {
        board = board.map(slideAndCombine)
    }
    
    private func slideAndCombine(_ row: [Block]) -> [Block] {
        var newRow = row
        newRow = slide(newRow)
        newRow = combine(newRow)
        newRow = slide(newRow)
        return newRow
    }
    
    func slide(_ row: [Block]) -> [Block] {
        let blocksWithNumbers = row.filter { $0.value > 0 }
        let emptyBlocksCount = row.count - blocksWithNumbers.count
        let arrayOfZeros = Array(repeating: Block(), count: emptyBlocksCount)
        let finalRow = arrayOfZeros + blocksWithNumbers
        if finalRow != row {
            isMoved = true
        }
        return finalRow
    }
    
    func combine(_ row: [Block]) -> [Block] {
        let newRow = row

        for column in (1..<row.count).reversed() {
            let prevColumn = column - 1
            let left = newRow[column].value
            let right = newRow[prevColumn].value

            if left == right {
                newRow[column].value = left + right
                newRow[prevColumn].value = 0
                isMoved = true
            }
        }
        return newRow
    }
    
    func move(to toward: Toward) {
        isMoved = false
                
        switch toward {
            case .left:
                flip()
                operateRows()
                flip()
            case .right:
                operateRows()
            case .up:
                rotate()
                flip()
                operateRows()
                flip()
                rotate()
            case .down:
                rotate()
                operateRows()
                rotate()
        }
        
        if isMoved {
            generateNewBlock()
        }
        checkWin()
    }
}


enum Toward {
    case left, right, up, down
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
