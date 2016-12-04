import pygame
import random


class Board:
    def __init__(self):
        self.khopi_attempt = 0
        self.board = [[2,0,0,0] ,
                      [2,0,0,0] ,
                      [2,0,0,0] ,
                      [2,0,0,0]]
        startRow = random.choice([0,1,2,3])
        startColumn = random.choice([0,1,2,3])
        #self.board[startRow][startColumn] = 2

    def moveLeft(self):
        print("move left")

    def moveRight(self):
        print("move right")

    def moveUp(self):
        for j in range(4):
            for i in range(4):
                closestIndex = self.findClosest( i, j, "up")
                if closestIndex != None:
                    if self.board[closestIndex][j] != self.board[i][j]:
                        self.shift(i,j, "up")
                    else:
                        self.board[i][j] = self.board[closestIndex][j] + self.board[i][j]
                        self.board[closestIndex][j] = 0
                        self.shift(i, j, "up")

    def moveDown(self):
        for j in range(4):
            for i in range(3, -1, -1):
                closestIndex = self.findClosest( i , j , "down")
                if closestIndex != None:
                    if self.board[closestIndex][j] != self.board[i][j]:
                        self.shift(i,j,"down")
                    else:
                        self.board[i][j] = self.board[closestIndex][j] + self.board[i][j]
                        self.board[closestIndex][j] = 0
                        self.shift(i,j,"down")
                    

    def shift(self, baseX, baseY, direction):
        if direction == "up":
            for i in range(baseX + 1 , len(self.board) - 1):
                closestIndex = self.findClosest( i , baseY , "up" )
                if closestIndex == None:
                    return
                self.board[i][baseY] = self.board[closestIndex][baseY]
                self.board[closestIndex][baseY] = 0
                
        elif direction == "down":
            for i in range(baseX - 1 , -1, -1):
                closestIndex = self.findClosest( i , baseY , "down")
                if closestIndex == None:
                    return
                self.board[i][baseY] = self.board[closestIndex][baseY]
                self.board[closestIndex][baseY] = 0
                
            
    def findClosest(self,currentX ,currentY, direction):
        if direction == "up":
            for i in range(currentX + 1, len(self.board)):
                if self.board[i][currentY] != 0:
                    return i
        elif direction == "down":
            for i in range(currentX - 1, -1 ,-1):
                if self.board[i][currentY] != 0:
                    return i
                

        return None


    def toString(self):
        returnStr = ""
        for i in self.board:
            returnStr += str(i) + "\n"
        return returnStr



a = Board()
a.toString()
#a.moveUp()
a.toString()
