from pyswip import Functor, Variable, Query, Prolog

class Connector:
    def __init__(self, file):
        self.prolog = Prolog()
        self.board = None
        self.prolog.consult(file)

    def setBoard(self,board):
        tranformedBoard = []
        for i in board:
            for j in i:
                tranformedBoard.append(j)
        self.board = tranformedBoard

    def addRule(self, rule):
        self.prolog.assertz(rule)

    def command(self, cmd):
        return self.prolog.query(cmd)

    def getMove(self, direction):
        if direction == 'up':
            return self.prolog.query('goUp(' + str(self.board) + ', New)')

pl = Connector('2048Bot.pl')
board = [ [0,0,0,0],
          [2,2,0,0],
          [0,0,2,0],
          [4,0,0,0] ]
pl.setBoard(board)
print(pl.getMove('up'))

