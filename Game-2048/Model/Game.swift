//
//  Game.swift
//  Game-2048
//
//  Created by Иван Вдовин on 07.05.2023.
//

import Foundation

class Game: ObservableObject {
    @Published var board = [[Block]]()
    let emptyBlock = Block()
    var sizeBoard = 4
    
    init() {
        resetBoard()
    }
    
    // Функция для генерации нового блока на игровом поле
    func generateNewBlock() {
        // Находим все свободные ячейки на игровом поле
        var emptyCells = [(Int, Int)]()
        for i in 0..<4 {
            for j in 0..<4 {
                if board[i][j].color == emptyBlock.color {
                    emptyCells.append((i, j)) // координаты пустых ячеек
                }
            }
        }
        // Если есть свободные ячейки, выбираем случайную и создаем новый блок
        if !emptyCells.isEmpty {
            let randomIndex = Int(arc4random_uniform(UInt32(emptyCells.count)))
            let (i, j) = emptyCells[randomIndex]
            board[i][j] = Block(value: Int.random(in: 1...2) * 2, color: .orange)
        } else {
//            gameOver()
        }
        
    }

    // Функция для проверки возможности объединения двух блоков
    func canMerge(block1: Block, block2: Block) -> Bool {
        return block1.value == block2.value && block1.value != 0
    }

    // Функция для объединения двух блоков
    func mergeBlocks(block1: Block, block2: Block) -> Block {
        let mergedBlock = Block(value: block1.value * 2, color: .orange)
        block1.value = 0
        block2.value = 0
        return mergedBlock
    }

    // Функция для проверки достижения числа 2048 на игровом поле
    func checkWin() -> Bool {
        for i in 0..<sizeBoard {
            for j in 0..<sizeBoard {
                if board[i][j].value == 2048 {
                    return true
                }
            }
        }
        return false
    }
    
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
    }
    
    // Функция для сдвига блоков на игровом поле
    func shiftBlocks(to toward: Toward) {
        switch toward {
            case .left:
            
            
                for row in 0..<4 {
                    for col in 1..<4 {
                        if board[row][col].color == emptyBlock.color {
                            continue
                        }

                        var newPosition = col
                        while newPosition > 0 && board[row][newPosition - 1].color == emptyBlock.color {
                            newPosition -= 1
                        }

                        if newPosition != col {
                            board[row][newPosition] = board[row][col]
                            board[row][col] = emptyBlock
                        } else if newPosition > 0 && board[row][newPosition - 1].value == board[row][newPosition].value {
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

                        if newPosition != col {
                            board[row][newPosition] = board[row][col]
                            board[row][col] = emptyBlock
                        } else if newPosition < 3 && board[row][newPosition + 1].value == board[row][newPosition].value {
                            board[row][newPosition + 1].value *= 2
                            board[row][newPosition] = emptyBlock
                        }
                    }
                }
            case .up:
                for row in 1..<4 {
                    for col in 0..<4 {
                        if board[row][col].color == emptyBlock.color {
                            continue
                        }

                        var newPosition = row
                        while newPosition > 0 && board[newPosition - 1][col].color == emptyBlock.color {
                            newPosition -= 1
                        }

                        if newPosition != row {
                            board[newPosition][col] = board[row][col]
                            board[row][col] = emptyBlock
                        } else if newPosition > 0 && board[newPosition - 1][col].value == board[newPosition][col].value {
                            board[newPosition - 1][col].value *= 2
                            board[newPosition][col] = emptyBlock
                        }
                    }
                }
            case .down:
                for row in (0..<4-1).reversed() {
                    for col in 0..<4 {
                        if board[row][col].color == emptyBlock.color {
                            continue
                        }
                        var newPosition = row
                        while newPosition < 3 && board[newPosition + 1][col].color == emptyBlock.color {
                            newPosition += 1
                        }
                        if newPosition != row {
                            board[newPosition][col] = board[row][col]
                            board[row][col] = emptyBlock
                        } else if newPosition < 3 && board[newPosition + 1][col].value == board[newPosition][col].value {
                            board[newPosition + 1][col].value *= 2
                            board[newPosition][col] = emptyBlock
                        }
                    }
                }
        }
        generateNewBlock()
    }
}

enum Toward {
    case left, right, up, down
}
