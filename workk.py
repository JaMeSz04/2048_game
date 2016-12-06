import random
import copy

class Board:
    def __init__(self):
        self.board = [ [0,0,0,0],
                       [0,0,0,0],
                       [0,0,0,0],
                       [0,0,0,0] ]
        startRow = random.choice([0, 1, 2, 3])
        startColumn = random.choice([0, 1, 2, 3])
        self.board[startRow][startColumn] = 2
        self.score = 0

    def up(self):
        board = copy.deepcopy(self.board)
        addScore = 0
        for j in range(len(board)):
            i = 0
            while i < len(board):
                if i < 0:
                    i = 0
                if board[i][j] == 0:
                    n = self.getNear('up',i,j,board)
                    if n != None:
                        board[i][j] = board[n][j]
                        board[n][j] = 0
                        if self.getNear('up',i,j,board) != None:
                            continue
                    i += 1
                elif board[i][j] != 0:
                    n = self.getNear('up',i,j,board)
                    if n != None:
                        if board[n][j] == board[i][j]:
                            board[i][j] = board[n][j] + board[i][j]
                            board[n][j] = 0
                            addScore += board[i][j]
                            i += 1
                        else:
                            i += 1
                    else:
                        i += 1

        return board,addScore

    def down(self):
        board = copy.deepcopy(self.board)
        addScore = 0
        for j in range(len(board) - 1,-1, -1):
            i = len(board) - 1
            while i >=0 :
                if i < 0:
                    i = 0
                if i >= len(board):
                    i = len(board) - 1
                if board[i][j] == 0:
                    n = self.getNear('down',i,j,board)
                    if n != None:
                        board[i][j] = board[n][j]
                        board[n][j] = 0
                        if self.getNear('down',i,j,board) != None:
                            continue
                    i -= 1
                elif board[i][j] != 0:
                    n = self.getNear('down',i,j,board)
                    if n != None:
                        if board[n][j] == board[i][j]:
                            board[i][j] = board[n][j] + board[i][j]
                            board[n][j] = 0
                            addScore += board[i][j]
                            i -= 1
                        else:
                            i -= 1
                    else:
                        i -= 1

        return board,addScore

    def left(self):
        board = copy.deepcopy(self.board)
        addScore = 0
        for i in range(len(board)):
            j = 0
            while j < len(board):
                if j < 0:
                    j = 0
                if board[i][j] == 0:
                    n = self.getNear('left',i,j,board)
                    if n != None:
                        board[i][j] = board[i][n]
                        board[i][n] = 0
                        if self.getNear('left',i,j,board) != None:
                            continue
                    j += 1
                elif board[i][j] != 0:
                    n = self.getNear('left',i,j,board)
                    if n != None:
                        if board[i][n] == board[i][j]:
                            board[i][j] = board[i][n] + board[i][j]
                            board[i][n] = 0
                            addScore += board[i][j]
                            j += 1
                        else:

                            j += 1
                    else:
                        j+= 1

        return board,addScore

    def right(self):
        board = copy.deepcopy(self.board)
        addScore = 0
        for i in range(len(board)):
            j = len(board) - 1
            while j > -1:
                if j < 0:
                    j = 0
                if j >= len(board):
                    j = len(board) - 1
                if board[i][j] == 0:
                    n = self.getNear('right',i,j,board)
                    if n != None:
                        board[i][j] = board[i][n]
                        board[i][n] = 0
                        if self.getNear('right',i,j,board) != None:
                            continue
                    j -= 1
                elif board[i][j] != 0:
                    n = self.getNear('right',i,j,board)
                    if n != None:
                        if board[i][n] == board[i][j]:
                            board[i][j] = board[i][n] + board[i][j]
                            board[i][n] = 0
                            addScore += board[i][j]
                            j -= 1
                        else:

                            j -= 1
                    else:
                        j -= 1

        return board,addScore

    def getNear(self, direction, baseX, baseY, board):
        if direction == 'up':
            for i in range(baseX, len(board)):
                if i == baseX:
                    continue
                if board[i][baseY] != 0:
                    return i
            return None

        elif direction == 'down':
            for i in range(baseX, -1, -1):
                if i == baseX:
                    continue
                if board[i][baseY] != 0:
                    return i
            return None

        elif direction == 'left':
            for j in range(baseY, len(board)):
                if j == baseY:
                    continue
                if board[baseX][j] != 0:
                    return j
            return None

        elif direction == 'right':
            for j in range(baseY, -1, -1):
                if j == baseY:
                    continue
                if board[baseX][j] != 0:
                    return j
            return None

    def performMove(self, direction):
        if direction == "up":
            self.board,score = self.up()
            self.score += score
        elif direction == "down":
            self.board,score = self.down()
            self.score += score
        elif direction == "left":
            self.board,score = self.left()
            self.score += score
        elif direction == "right":
            self.board,score = self.right()
            self.score += score
        else:
            return
        self.reGenerate()
        self.toString()

        return self.board

    def reGenerate(self):
        complete = False
        while not complete:
            startRow = random.choice([0, 1, 2, 3])
            startColumn = random.choice([0, 1, 2, 3])
            if self.board[startRow][startColumn] != 0:
                continue
            self.board[startRow][startColumn] = random.choice([2,2,2,2,2,2,2,2,2,4]) #10% of respawning 4
            complete = True

    #return predict board, predict total score
    def getPredictMove(self, direction):
        if direction == "up":
            board, score = self.up()
            return board, self.score + score
        elif direction == "down":
            board, score = self.down()
            return board, self.score + score
        elif direction == "left":
            board, score = self.left()
            return board, self.score + score
        elif direction == "right":
            board, score = self.right()
            return board, self.score + score

    def getScore(self):
        return self.score


    def toString(self):
        for i in self.board:
            print(i)

    def isWin(self):
        for i in self.board:
            if 2048 in i:
                return True
        return False


    def isLose(self):
        for i in self.board:
            if 0 in i:
                return False
        return True



