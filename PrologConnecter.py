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
        return list(self.prolog.query(cmd))

    def getMove(self, direction):
        if direction == 'up':
            return list(self.prolog.query('move(' + str(self.board) + ',u, New)'))

        elif direction == 'down':
            return list(self.prolog.query('move(' + str(self.board) + ',d, New)'))

        elif direction == 'left':
            return list(self.prolog.query('move(' + str(self.board) + ',l, New)'))

        elif direction == 'right':
            return list(self.prolog.query('move(' + str(self.board) + ',r, New)'))

    def solve(self):
        return list(self.prolog.query('solve(' + str(self.board) + ', 4 )'))

pl = Connector('2048Bot.pl')
board = [ [0,2,0,0],
          [2,2,0,0],
          [0,2,2,0],
          [4,2,0,0] ]

pl.setBoard(board)
print(pl.getMove('up'))
print(pl.getMove('down'))
print(pl.solve())
print("")

