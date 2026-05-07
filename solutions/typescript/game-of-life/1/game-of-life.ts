export class GameOfLife {
  private matrix: number[][]
  
  constructor(matrix: number[][]) {
    this.matrix = matrix.map((row) => [...row])
  }

  public tick(): unknown {
    const nextGeneration = this.matrix.map((row, rowIndex) =>
      row.map((cell, columnIndex) => {
        const liveNeighbors = this.countLiveNeighbors(rowIndex, columnIndex)

        if (cell === 1) {
          return liveNeighbors === 2 || liveNeighbors === 3 ? 1 : 0
        }

        return liveNeighbors === 3 ? 1 : 0
      })
    )

    this.matrix = nextGeneration
    return this.state()
  }

  public state(): unknown {
    return this.matrix.map((row) => [...row])
  }

  private countLiveNeighbors(row: number, column: number): number {
    let count = 0

    for (let rowOffset = -1; rowOffset <= 1; rowOffset++) {
      for (let columnOffset = -1; columnOffset <= 1; columnOffset++) {
        if (rowOffset === 0 && columnOffset === 0) {
          continue
        }

        const neighborRow = row + rowOffset
        const neighborColumn = column + columnOffset

        if (
          neighborRow >= 0 &&
          neighborRow < this.matrix.length &&
          neighborColumn >= 0 &&
          neighborColumn < this.matrix[neighborRow].length
        ) {
          count += this.matrix[neighborRow][neighborColumn]
        }
      }
    }

    return count
  }
}