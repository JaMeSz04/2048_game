
import random


class Board:
    def __init__(self):
        self.khopi_attempt = 0
        self.board = [[2,2,0,2] ,
                      [0,0,2,0] ,
                      [2,0,0,2] ,
                      [2,0,0,0]]
        startRow = random.choice([0,1,2,3])
        startColumn = random.choice([0,1,2,3])
        #self.board[startRow][startColumn] = 2

    def moveLeft(self):
        for i in range(4):
            for j in range(4):
                closestIndex = self.findClosest( i , j , "left")
                if closestIndex != None:
                    if self.board[i][closestIndex] != self.board[i][j]:
                        self.shift(i,j,"left")
                    else:
                        self.board[i][j] = self.board[i][closestIndex] + self.board[i][j]
                        self.board[i][closestIndex] = 0
                        self.shift(i,j,"left")


    def moveRight(self):
        print("move right")

    def moveUp(self):
        for j in range(4):
            for i in range(4):
                closestIndex = self.findClosest( i, j, "up")
                if closestIndex != None:
                    if self.board[closestIndex][j] != self.board[i][j] or self.board[i][j] == 0:
                        self.shift(i,j, "up")
                    else:
                        self.board[i][j] = self.board[closestIndex][j] + self.board[i][j]
                        self.board[closestIndex][j] = 0
                        self.shift(i, j, "up")

    def moveDown(self):
        for j in range(4):
            for i in range(3, -1, -1):
                closestIndex = self.findClosest( i , j , "down")
                print ("Closest Down : " + str(closestIndex) + " : " + str(j) + "index : " + str(closestIndex))
                if closestIndex != None:
                    print('no plus with num : ' + str(self.board[closestIndex][j]) +" and " +str(self.board[i][j]))
                    if self.board[closestIndex][j] != self.board[i][j]:
                        self.shift(i,j,"down")
                    else:
                        print('will plus')
                        self.board[i][j] = self.board[closestIndex][j] + self.board[i][j]
                        self.board[closestIndex][j] = 0
                        print("resulted : " + str(self.board[i][j]))
                        self.shift(i,j,"down")
                    

    def shift(self, baseX, baseY, direction):
        if direction == "up":
            
            #fix 0 round up bug
            if self.board[baseX][baseY] == 0:
                closestIndex = self.findClosest( baseX , baseY , "up" )
                self.board[baseX][baseY] = self.board[closestIndex][baseY]
                self.board[closestIndex][baseY] = 0
                
            for i in range(baseX + 1, len(self.board)):
                closestIndex = self.findClosest( i , baseY , "up" )
                if closestIndex == None:
                    return
                if self.board[i + 1][baseY] == self.board[closestIndex][baseY]:
                    self.board[i + 1][baseY] = self.board[i + 1][baseY] + self.board[closestIndex][baseY]
                    self.board[closestIndex][baseY] = 0
                else:   
                    self.board[i][baseY] = self.board[closestIndex][baseY]
                    self.board[closestIndex][baseY] = 0
                
        elif direction == "down":

            if self.board[baseX][baseY] == 0:
                closestIndex = self.findClosest( baseX , baseY , "down" )
                self.board[baseX][baseY] = self.board[closestIndex][baseY]
                self.board[closestIndex][baseY] = 0
                print("bug check ")
                self.toString()
                
            for i in range(baseX - 1,0, -1):
                closestIndex = self.findClosest(i, baseY , "down")
                print("Next closest!! : " + str(closestIndex))
                if closestIndex == None:
                    return
                self.board[i][baseY] = self.board[closestIndex][baseY]
                self.board[closestIndex][baseY] = 0
                
        elif direction == "left":
            for i in range(baseY + 1, len(self.board) - 1):
                closestIndex = self.findClosest( baseX , i , "left")
                if closestIndex == None:
                    return
                self.board[baseX][i] = self.board[baseX][closestIndex]
                
            
    def findClosest(self,currentX ,currentY, direction):
        if direction == "up":
            for i in range(currentX + 1, len(self.board)):
                if self.board[i][currentY] != 0:
                    return i
        elif direction == "down":
            for i in range(currentX - 1, -1,-1):
                if self.board[i][currentY] != 0:
                    print( "found closest : " + str(self.board[i][currentY]) + " at " + str(i))
                    return i
        elif direction == "left":
            for i in range(currentY + 1, len(self.board)):
                if self.board[currentX][i]:
                    return i

        return None


    def toString(self):
        returnStr = ""
        for i in self.board:
            print i
        #return returnStr



a = Board()
a.toString()
#a.moveUp()
#a.toString()
