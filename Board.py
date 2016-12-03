import pygame
import random


class Board:
    def __init__(self):
        self.khopi_attempt = 0
        self.board = [[0,0,0,0] ,
                      [0,0,0,0] ,
                      [0,0,0,0] ,
                      [0,0,0,0]]
        startRow = random.choice([0,1,2,3])
        startColumn = random.choice([0,1,2,3])
        self.board[startRow][startColumn] = 2



    def moveLeft(self):
        print("move left")

    def moveRight(self):
        print("move right")

    def moveUp(self):
        for i in range(4):
            for j in range(4):
                #case up is 0
                if self.board[i][j] == 0 and self.board[i+1][j] != 0:
                    self.board[i][j] = self.board[i+1][j]
                    self.board[i+1][j] = 0
                elif self.board[i][j] == self.board[i+1][j]:
                    self.board[i][j] = self.board[i][j] + self.board[i+1][j]
                    self.board[i+1][j] = 0
                    #shift other box up
                    for k in range(i + 1, 4):
                        while True:
                            if self.board[k + 1][j] != 0:
                                self.board[k][j] = self.board[k+1][j]
    def haveSame(self,currentRow,currentColumn,dir):
        if dir == 'up':
            for i in range(currentRow,4):
                if currentX:








        print("move up")

    def moveDown(self):
        print("move down")
