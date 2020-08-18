import UIKit

class Matrix<T> {
    private var matrix: [[T]]
    private var size: Int
    private var zeroIndexedSize: Int
    private var cycles: Int
    
    init(size: Int) {
        self.size = size
        zeroIndexedSize = size - 1
        cycles = self.size / 2
   
        matrix = .init(repeating: .init(repeating: 0 as! T, count: size), count: size)
   
        for i in 0..<size {
            for j in 0..<size {
                matrix[i][j] = (i*size) + j + 1 as! T
            }
        }
    }
    
    init(size: MatrixSize) {
        switch size {
        case .small:
            self.size = 3
        case .medium:
            self.size = 4
        case .large:
            self.size = 6
        }
        
        let foodString = "🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑🍍🥥🥝🍅🍆🥑🥦🥬🥒🌶🌽🥕🧄🧅🥔🍠🥐🥯🥖🥨🥚🍳🧈🥞🧇🥓🥩"
        let animalsString = "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷🐸🐵🐔🦆🦅🦉🦇🐺🐗🐴🐝🐛🦋🐌🐞🐜🦟🦗"
        let sportsString = "⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱🪀🏓🏸🏒"

        let food = Array(foodString)
        let animals = Array(animalsString)
        let sports = Array(sportsString)
        
        zeroIndexedSize = self.size - 1
        cycles = self.size / 2
        
        matrix = [[T]]()
        
        for _ in 0..<self.size {
            let emptyArray = [T]()
            matrix.append(emptyArray)
        }
        
        var foodIndex = 0
        var animalsIndex = 0
        var sportsIndex = 0
        
        for x in 0...zeroIndexedSize {
            for y in 0...zeroIndexedSize {
                let cycle = determineCycle(x: x, y: y)
                if cycle == 1 {
                    matrix[x].append(food[foodIndex] as! T)
                    if foodIndex < food.count - 1 {
                        foodIndex += 1
                    }
                } else if cycle == 2 {
                    matrix[x].append(animals[animalsIndex] as! T)
                    if animalsIndex < animals.count - 1 {
                        animalsIndex += 1
                    }
                } else if cycle == 3 {
                    matrix[x].append(sports[sportsIndex] as! T)
                    if sportsIndex < sports.count - 1 {
                        sportsIndex += 1
                    }
                } else {
                    matrix[x].append(food.randomElement() as! T)
                }
            }
        }
    }
    
    func prettyPrint() {
        for array in matrix {
            print(array)
        }
    }
    
  // Rotate square matrix 90 degrees to the right.
  // Constraint: it must be in place so no new arrays may be created
    func rotate90Right() {
        print("rotating 90 degrees to the right")
    // iterates through the cycles.
        for cycle in 0..<cycles {
            print("cycle is \(cycle)")
        // iterates through loops
            for loop in cycle..<zeroIndexedSize - cycle {
                let temp = matrix[cycle][loop]
                matrix[cycle][loop] = matrix[zeroIndexedSize - loop][cycle]
                matrix[zeroIndexedSize - loop][cycle] = matrix[zeroIndexedSize - cycle][zeroIndexedSize - loop]
                matrix[zeroIndexedSize - cycle][zeroIndexedSize - loop] = matrix[loop][zeroIndexedSize - cycle]
                matrix[loop][zeroIndexedSize - cycle] = temp
            }
        }
    }
    
    private func determineCycle(x: Int, y: Int) -> Int {
        var high = zeroIndexedSize
        while high > 0 {
            for low in 0..<cycles {
                if (x == low) || (y == low) || (x == high) || (y == high) {
                    return low + 1
                } else {
                    high -= 1
                }
            }
        }
        return high
    }
}

enum MatrixSize {
    case small
    case medium
    case large
}

let matrix = Matrix<Any>(size: .small)
matrix.prettyPrint()
matrix.rotate90Right()
matrix.prettyPrint()
let numbersMatrix = Matrix<Int>(size: 3)
numbersMatrix.prettyPrint()
numbersMatrix.rotate90Right()
numbersMatrix.prettyPrint()
let largeMatrix = Matrix<Any>(size: .large)
largeMatrix.prettyPrint()
largeMatrix.rotate90Right()
largeMatrix.prettyPrint()



