

import random


class Board:
    def __init__(self):
        self.board = [ [2,2,2,0],
                       [2,2,2,2],
                       [2,2,0,2],
                       [2,2,2,2] ]

    def up(self):
        for j in range(len(self.board)):
            i = 0
            while i < len(self.board):
                if i < 0:
                    i = 0
                if self.board[i][j] == 0:
                    n = self.getNear('up',i,j)
                    if n != None:
                        self.board[i][j] = self.board[n][j]
                        self.board[n][j] = 0
                        if self.getNear('up',i,j) != None:
                            continue
                    i += 1
                elif self.board[i][j] != 0:
                    n = self.getNear('up',i,j)
                    if n != None:
                        if self.board[n][j] == self.board[i][j]:
                            self.board[i][j] = self.board[n][j] + self.board[i][j]
                            self.board[n][j] = 0
                            i += 1
                        else:
                            i += 1
                            break

    def down(self):
        for j in range(len(self.board) - 1,-1, -1):
            i = len(self.board) - 1
            while i >=0 :
                if i < 0:
                    i = 0
                if i >= len(self.board):
                    i = len(self.board) - 1
                if self.board[i][j] == 0:
                    n = self.getNear('down',i,j)
                    if n != None:
                        self.board[i][j] = self.board[n][j]
                        self.board[n][j] = 0
                        if self.getNear('down',i,j) != None:
                            continue
                    i -= 1
                elif self.board[i][j] != 0:
                    n = self.getNear('down',i,j)
                    if n != None:
                        if self.board[n][j] == self.board[i][j]:
                            self.board[i][j] = self.board[n][j] + self.board[i][j]
                            self.board[n][j] = 0
                            i -= 1
                        else:
                            i -= 1
                            break


    def left(self):
        for i in range(len(self.board)):
            j = 0
            while j < len(self.board):
                if j < 0:
                    j = 0
                if self.board[i][j] == 0:
                    n = self.getNear('left',i,j)
                    if n != None:
                        self.board[i][j] = self.board[i][n]
                        self.board[i][n] = 0
                        if self.getNear('left',i,j) != None:
                            continue
                    j += 1
                elif self.board[i][j] != 0:
                    n = self.getNear('left',i,j)
                    if n != None:
                        if self.board[i][n] == self.board[i][j]:
                            self.board[i][j] = self.board[i][n] + self.board[i][j]
                            self.board[i][n] = 0
                            j += 1
                        else:
                            j += 1
                            break

    def right(self):
        for i in range(len(self.board)):
            j = len(self.board) - 1
            while j >= 0:
                if j < 0:
                    j = 0
                if j >= len(self.board):
                    j = len(self.board) - 1
                if self.board[i][j] == 0:
                    n = self.getNear('right',i,j)
                    if n != None:
                        self.board[i][j] = self.board[i][n]
                        self.board[i][n] = 0
                        if self.getNear('right',i,j) != None:
                            continue
                    j -= 1
                elif self.board[i][j] != 0:
                    n = self.getNear('right',i,j)
                    if n != None:
                        if self.board[i][n] == self.board[i][j]:
                            self.board[i][j] = self.board[i][n] + self.board[i][j]
                            self.board[i][n] = 0
                            j -= 1
                        else:
                            j -= 1
                            break
            
    def getNear(self, direction, baseX, baseY):
        if direction == 'up':
            for i in range(baseX, len(self.board)):
                if i == baseX:
                    continue
                if self.board[i][baseY] != 0:
                    return i
            return None

        elif direction == 'down':
            for i in range(baseX, -1, -1):
                if i == baseX:
                    continue
                if self.board[i][baseY] != 0:
                    return i
            return None

        elif direction == 'left':
            for j in range(baseY, len(self.board)):
                if j == baseY:
                    continue
                if self.board[baseX][j] != 0:
                    return j
            return None

        elif direction == 'right':
            for j in range(baseY, -1, -1):
                if j == baseY:
                    continue
                if self.board[baseX][j] != 0:
                    return j
            return None
        

    def toString(self):
        for i in self.board:
            print(i)
a= Board()
a.toString()
a.right()
print("")
a.toString()

