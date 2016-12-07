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
        self.isChange = False

    def up(self,theBoard):
        if theBoard == None:
            board = copy.deepcopy(self.board)
        else:
            board = copy.deepcopy(theBoard)
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

    def down(self, theBoard):
        if theBoard == None:
            board = copy.deepcopy(self.board)
        else:
            board = copy.deepcopy(theBoard)
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

    def left(self,theBoard):
        if theBoard == None:
            board = copy.deepcopy(self.board)
        else:
            board = copy.deepcopy(theBoard)
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

    def right(self,theBoard):
        if theBoard == None:
            board = copy.deepcopy(self.board)
        else:
            board = copy.deepcopy(theBoard)
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
            newBoard,score = self.up(None)
            self.score += score
        elif direction == "down":
            newBoard,score = self.down(None)
            self.score += score
        elif direction == "left":
            newBoard,score = self.left(None)
            self.score += score
        elif direction == "right":
            newBoard,score = self.right(None)
            self.score += score
        else:
            return
        if newBoard == self.board:
            self.isChange = False
        else:
            self.board = newBoard
            self.isChange = True

        if self.isChange:
            self.reGenerate()
        self.isChange = False
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
            board, score = self.up(None)
            return board, self.score + score
        elif direction == "down":
            board, score = self.down(None)
            return board, self.score + score
        elif direction == "left":
            board, score = self.left(None)
            return board, self.score + score
        elif direction == "right":
            board, score = self.right(None)
            return board, self.score + score

    def getPredictMoveOf(self, direction, theBoard):
        if direction == "up":
            board, score = self.up(theBoard)
            return board, self.score + score
        elif direction == "down":
            board, score = self.down(theBoard)
            return board, self.score + score
        elif direction == "left":
            board, score = self.left(theBoard)
            return board, self.score + score
        elif direction == "right":
            board, score = self.right(theBoard)
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
        allMove = ['up','down','left','right']
        for i in allMove:
            if self.getPredictMove(i) != self.board:
                return False
        return True




