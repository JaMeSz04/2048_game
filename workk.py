import random
import copy
import itertools
import math

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
        #self.toString()

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




    def getPredictAll(self,board):
        allMove = ['up', 'down', 'left', 'right']
        return [self.getPredictMoveOf(i,board) for i in allMove]

    def isLose(self):
        allMove = ['up','down','left','right']
        for i in allMove:
            if self.getPredictMove(i) != self.board:
                return False
        return True

    def isLoseWith(self,board):
        allMove = ['up', 'down', 'left', 'right']
        for i in allMove:
            if self.getPredictMoveOf(i,board) != self.board:
                return False
        return True

    def solve(self,board,oldBoard,depth, isMove = False):
        if type(board) == tuple:
            board = board[0]
        if depth == 0 or (isMove and self.isLoseWith(board)):
            return self.heuristic(board,oldBoard)

        alpha = self.heuristic(board,oldBoard)

        if isMove:
            for child in self.getPredictAll(board):
                alpha = max(alpha, self.solve(child,oldBoard, depth - 1, False))
        else:
            alpha = 0
            zeros = self.getEmptyCells(board)

            for i,j in zeros:
                temp1 = [[x for x in row] for row in board]
                temp2 = [[x for x in row] for row in board]
                temp1[i][j] = 2
                temp2[i][j] = 4
                twoProbab = ( 0.9 * self.solve(temp1,oldBoard, depth - 1, True) / len(zeros))
                fourProbab = ( 0.1 * self.solve(temp2,oldBoard, depth - 1, True) / len(zeros))
                alpha += twoProbab + fourProbab
                return alpha
        return alpha


    def getEmptyCells(self,board):
        if type(board) == tuple:
            board = board[0]
        zeros = []
        for i in range(len(board)):
            for j in range(len(board)):
                if board[i][j] == 0:
                    zeros.append((i,j))

        return zeros

    def heuristic(self,board,oldBoard):
        if self.isLoseWith(board):
            return -float("inf")
        val = 0
        empty = len(self.getEmptyCells(board))
        val += empty
        val = val - (16 - empty)
        val += self.getNumEdgeLarge(board) * 2
        val += self.getNumEdgeCorner(board)
        #val += self.scoreClose(board)
        #val += self.secondLargestClose(board) / 100
        #val += self.closeToMax(board)
        #val -= self.numMinCorner(board)
        #val -= self.manhatton(board)
        if oldBoard == board:
            return 0
        return val

    def numMinCorner(self,board):
        num = 0
        maximum = 0
        secondMax = 0
        for i in board:
            for j in i:
                if j > maximum:
                    maximum = j
        if board[0][0] != maximum:
            num += 2
        if board[0][len(board) - 1] != maximum:
            num += 2
        if board[len(board) - 1][0] != maximum:
            num += 2
        if board[len(board) - 1][len(board) - 1] != maximum:
            num += 2
        return num



    def closeToMax(self,board):
        total = 0
        for i in board:
            for j in i:
                total += j
        return total / 1000
    def scoreClose(self,board):
        num = 0
        maximum = 0
        secondMax = 0
        for i in board:
            for j in i:
                if j > maximum:
                    maximum = j
        returnVal = math.log(2048, 2) - math.log(maximum,2)
        if returnVal < 0:
            return 0
        return returnVal

    def getNumEdgeLarge(self,board):
        num = 0
        maximum = 0
        secondMax = 0
        for i in board:
            for j in i:
                if j > maximum:
                    maximum = j

        for i in range(len(board)):
            for j in range(len(board)):
                if i == 0:
                    if board[i][j] == maximum:
                        num += 2
                    if board[i][j] == secondMax:
                        num += 1
                if i == len(board) - 1:
                    if board[i][j] == maximum:
                        num += 2
                    if board[i][j] == secondMax:
                        num += 1
                if j == 0:
                    if board[i][j] == maximum:
                        num += 2
                    if board[i][j] == secondMax:
                        num += 1

                if i == len(board) - 1:
                    if board[i][j] == maximum:
                        num += 2
                    if board[i][j] == secondMax:
                        num += 1
        return num

    def manhatton(self,board):
        num = 0
        maximum = 0
        secondMax = 0
        maxI = 0
        maxJ = 0
        maxI2 = 0
        maxJ2 = 0
        for i in board:
            for j in i:
                if j > maximum:
                    maximum = j
        for i in range(len(board)):
            for j in range(len(board)):
                if board[i][j] == maximum:
                    maxI = i
                    maxJ = j
                if board[i][j] == secondMax:
                    maxI2 = i
                    maxJ2 = j
        return abs(maxI2 - maxI) + abs(maxJ2 - maxJ)

    def getNumEdgeCorner(self,board):
        if type(board) == tuple:
            board = board[0]
        num = 0
        maximum = 0

        if board[0][0] == maximum:
            num += 2
        if board[len(board)- 1][0] == maximum:
            num += 2
        if board[0][len(board) - 1] == maximum:
            num += 2
        if board[len(board) -1][len(board) -1] == maximum:
            num += 2
        return num

    def secondLargestClose(self, board):
        if type(board) == tuple:
            board = board[0]
        num = 0
        maximum = 0
        secondMax = []
        for i in board:
            for j in i:
                if j > maximum:
                    maximum = j


        for i in range(len(board)):
            for j in range(len(board)):
                if board[i][j] == maximum:
                    tempCol = j + 1
                    while tempCol <= len(board) - 1:
                        if board[i][tempCol] != 0:
                            num += board[i][tempCol]
                        tempCol += 1

                    tempCol = j - 1
                    while tempCol >= 0:
                        if board[i][tempCol] != 0:
                            if board[i][tempCol] == secondMax or board[i][tempCol] == maximum:
                                num += 1
                            elif board[i][tempCol] == maximum:
                                num += 2
                            else:
                                break
                        tempCol -= 1


                    tempRow = i + 1
                    while tempRow <= len(board) - 1:
                        if board[tempRow][j] != 0:
                            if board[tempRow][j] == secondMax or board[tempRow][j] == maximum:
                                num += 1
                            elif board[tempRow][j] == maximum:
                                num += 2
                            else:
                                break
                        tempRow += 1

                    tempRow = i - 1
                    while tempRow >= 0:
                        if board[tempRow][j] != 0:
                            if board[tempRow][j] == secondMax or board[tempRow][j] == maximum:
                                num += 1
                            elif board[tempRow][j] == maximum:
                                num += 2
                            else:
                                break
                        tempRow -= 1
        return num











