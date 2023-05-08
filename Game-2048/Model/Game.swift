//
//  Game.swift
//  Game-2048
//
//  Created by Иван Вдовин on 07.05.2023.
//

import Foundation

class Game: ObservableObject {
    @Published var board = [[Block]]()
    let emptyBlock: Block = Block()
    var sizeBoard: Int = 4
    @Published var victory: Bool = false
    @Published var gameOver: Bool = false
    
    init() {
        resetBoard()
    }
    
    // Функция для генерации нового блока
    func generateNewBlock() {
        // Находим все свободные блоки
        var emptyBlocks = [(Int, Int)]()
        for i in 0..<4 {
            for j in 0..<4 {
                if board[i][j].color == emptyBlock.color {
                    emptyBlocks.append((i, j)) // Координаты пустых ячеек
                }
            }
        }
        // Если есть свободные блоки, выбираем случайный и создаем новый блок
        if !emptyBlocks.isEmpty {
            let randomIndex = Int(arc4random_uniform(UInt32(emptyBlocks.count)))
            let (i, j) = emptyBlocks[randomIndex]
            board[i][j] = Block(value: Int.random(in: 1...2) * 2, color: .orange)
        } else {
            gameOver = true
        }
    }

    // Функция для проверки достижения числа 2048
    func checkWin() {
        for i in 0..<sizeBoard {
            for j in 0..<sizeBoard {
                if board[i][j].value == 2048 {
                    victory = true
                }
            }
        }
    }
    
    // Обновляем поле
    func resetBoard() {
        var newBoard = [[Block]]()
        for _ in 0...sizeBoard {
            var row = [Block]()
            
            for _ in 0...sizeBoard {
                row.append(Block())
            }
            newBoard.append(row)
        }
        board = newBoard
        generateNewBlock()
        victory = false
        gameOver = false
    }
    
    // Функция для сдвига блоков на игровом поле
    func shiftBlocks(to toward: Toward) {
        switch toward {
            case .left:
                for row in 0..<4 {
                    for col in 1..<4 {
                        if board[row][col].color == emptyBlock.color { // Скипаем сразу все пустые блоки
                            continue
                        }
                        
                        var newPosition = col
                        while newPosition > 0 && board[row][newPosition - 1].color == emptyBlock.color {
                            newPosition -= 1
                        }

                        if newPosition != col { // Если мы таки переместились духовно, то перемещаемся материально
                            board[row][newPosition] = board[row][col]
                            board[row][col] = emptyBlock
                        }
                        
                        if newPosition > 0 && board[row][newPosition - 1].value == board[row][newPosition].value { // Мерджим значения блоков, если они равны
                            board[row][newPosition - 1].value *= 2
                            board[row][newPosition] = emptyBlock
                        }
                    }
                }
            case .right:
                for row in 0..<4 {
                    for col in (0..<3).reversed() {
                        if board[row][col].color == emptyBlock.color {
                            continue
                        }

                        var newPosition = col
                        while newPosition < 3 && board[row][newPosition + 1].color == emptyBlock.color {
                            newPosition += 1
                        }

                        if newPosition != col { // Если мы таки переместились духовно, то перемещаемся материально
                            board[row][newPosition] = board[row][col]
                            board[row][col] = emptyBlock
                        }
                        
                        if newPosition < 3 && board[row][newPosition + 1].value == board[row][newPosition].value { // Мерджим значения блоков, если они равны
                            board[row][newPosition + 1].value *= 2
                            board[row][newPosition] = emptyBlock
                        }
                    }
                }
            case .up:
                for col in 0..<4 {
                    for row in 1..<4 { // Итерируемся сверху вниз
                        if board[row][col].color == emptyBlock.color { // Скипаем сразу все пустые блоки
                            continue
                        }
                        
                        var newPosition = row
                        while newPosition > 0 && board[newPosition - 1][col].color == emptyBlock.color {
                            newPosition -= 1
                        }
                        
                        if newPosition != row { // Если мы таки переместились духовно, то перемещаемся материально
                            board[newPosition][col] = board[row][col]
                            board[row][col] = emptyBlock
                        }
                        
                        if newPosition > 0 && board[newPosition - 1][col].value == board[newPosition][col].value { // Мерджим значения блоков, если они равны
                            board[newPosition - 1][col].value *= 2
                            board[newPosition][col] = emptyBlock
                        }
                    }
                }
            case .down:
                for col in 0..<4 {
                    for row in (0..<3).reversed() { // Итерируемся снизу вверх
                        if board[row][col].color == emptyBlock.color { // Скипаем сразу все пустые блоки
                            continue
                        }
                        
                        var newPosition = row
                        while newPosition < 3 && board[newPosition + 1][col].color == emptyBlock.color {
                            newPosition += 1
                        }
                        
                        if newPosition != row { // Если мы таки переместились духовно, то перемещаемся материально
                            board[newPosition][col] = board[row][col]
                            board[row][col] = emptyBlock
                        }
                        
                        if newPosition < 3 && board[newPosition + 1][col].value == board[newPosition][col].value { // Мерджим значения блоков, если они равны
                            board[newPosition + 1][col].value *= 2
                            board[newPosition][col] = emptyBlock
                        }
                    }
                }
        }
        generateNewBlock() // После каждого свайпа создаем блок
        checkWin()
    }
}

enum Toward {
    case left, right, up, down
}
