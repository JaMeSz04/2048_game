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
        for i in range(4):
            closestIndex = self.findClosest( i, 0, "up")
            if closestIndex != None:
                if self.board[closestIndex][0] != self.board[i][0]:
                    self.shift(i,0, "up")
                else:
                    self.board[i][0] = self.board[closestIndex][0] + self.board[i][0]
                    self.board[closestIndex][0] = 0
                    self.shift(i, 0, "up")


    def shift(self, baseX, baseY, direction):
        if direction == "up":
            for i in range(baseX + 1 , len(self.board) - 1):
                closestIndex = self.findClosest( i , 0 , "up" )
                if closestIndex == None:
                    return
                self.board[i][baseY] = self.board[closestIndex][baseY]
                self.board[closestIndex][baseY] = 0
            
    def findClosest(self,currentX ,currentY, direction):
        if direction == "up":
            for i in range(currentX + 1, len(self.board)):
                if self.board[i][currentY] != 0:
                    return i

        return None


    def toString(self):
        returnStr = ""
        for i in self.board:
            returnStr += str(i) + "\n"
        return returnStr


    def moveDown(self):
        print("move down")



a = Board()
a.toString()
#a.moveUp()
a.toString()
