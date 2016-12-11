from pyswip import Functor, Variable, Query, Prolog

class Connector:
    def __init__(self, file):

        self.file = file
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
            return list(self.prolog.query('move(' + str(self.board) + ',u, New)'))
        elif direction == 'down':
            return list(self.prolog.query('move(' + str(self.board) + ',d, New)'))
        elif direction == 'left':
            return list(self.prolog.query('move(' + str(self.board) + ',l, New)'))
        elif direction == 'right':
            return list(self.prolog.query('move(' + str(self.board) + ',r, New)'))

    def aiMove(self, board, depth):
        self.setBoard(board)
        return list( self.prolog.query('aigame(' + str(self.board) + ',' + str(depth) + ',Move)'))