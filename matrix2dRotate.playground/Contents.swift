import UIKit

class Matrix<T> {
    private var matrix = [[T]]()
    private var size: Int
    private var zeroIndexedSize: Int
    private var cycles: Int
    
    init(size: Int) where T == Int {
        self.size = size
        zeroIndexedSize = size - 1
        cycles = self.size / 2
   
        for i in 0..<size {
            let emptyArray = [T]()
            matrix.append(emptyArray)
            for j in 0..<size {
                let math = (i*size) + j + 1
                matrix[i].append(math)
            }
        }
    }
    
    init(size: MatrixSize) where T == Character {
        switch size {
        case .small:
            self.size = 3
        case .medium:
            self.size = 4
        case .large:
            self.size = 6
        }
        
        var food = Array("🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑🍍🥥🥝🍅🍆🥑🥦🥬🥒🌶🌽🥕🧄🧅🥔🍠🥐🥯🥖🥨🥚🍳🧈🥞🧇🥓🥩")
        var animals = Array("🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷🐸🐵🐔🦆🦅🦉🦇🐺🐗🐴🐝🐛🦋🐌🐞🐜🦟🦗")
        var sports = Array("⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱🪀🏓🏸🏒")
        
        zeroIndexedSize = self.size - 1
        cycles = self.size / 2
        
        for x in 0...zeroIndexedSize {
            let emptyArray = [T]()
            matrix.append(emptyArray)
            for y in 0...zeroIndexedSize {
                let cycle = determineCycle(x: x, y: y)
                if cycle == 1 {
                    matrix[x].append(food.popLast()!)
                } else if cycle == 2 {
                    matrix[x].append(animals.popLast()!)
                } else if cycle == 3 {
                    matrix[x].append(sports.popLast()!)
                } else {
                    matrix[x].append(food.randomElement()!)
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
    
    func alternativeRotate(_ placeholder: T) {
        var newMatrix = [[T]](repeating: [T](repeating: placeholder, count: size), count: size)
        
        for i in 0..<size {
            for j in 0..<size {
                newMatrix[j][size - i - 1] = matrix[i][j]
            }
        }
        
        matrix = newMatrix
    }
}

enum MatrixSize {
    case small
    case medium
    case large
}

let matrix = Matrix<Character>(size: .small)
matrix.prettyPrint()
matrix.rotate90Right()
matrix.prettyPrint()
let numbersMatrix = Matrix<Int>(size: 3)
numbersMatrix.prettyPrint()
numbersMatrix.rotate90Right()
numbersMatrix.prettyPrint()
let largeMatrix = Matrix<Character>(size: .large)
largeMatrix.prettyPrint()
largeMatrix.rotate90Right()
largeMatrix.prettyPrint()

let numberMatrx = Matrix<Int>(size: 6)
numberMatrx.prettyPrint()
numberMatrx.alternativeRotate(0)
numberMatrx.prettyPrint()




