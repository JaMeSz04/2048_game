import pygame
from Board import*

CELL_WIDTH = 230
CELL_HEIGHT = 130


class Color:
    BLACK = (0, 0, 0)
    WHITE = (255, 255, 255)

class Game:
    def __init__(self):
        pygame.init()
        pygame.display.set_caption("2048 Game by ShubU")
        self.score = "Score : "
        self.board = Board()
        self.gameDisplay = pygame.display.set_mode((800,600))
        self.font = pygame.font.SysFont("monospace", 28)
        self.clock = pygame.time.Clock()
        self.over = False
        self.doAI = False
        self.prevMove = None
        self.start()


    def clearText(self):
        label = self.font.render(self.score + str(self.board.getScore()), 1, (0, 0, 0))
        self.gameDisplay.blit(label, (20, 20))

    def drawCell(self):
        for i in range(len(self.board.board)):
            for j in range(len(self.board.board)):
                myimage = pygame.image.load("assets/" + str(self.board.board[i][j]) + ".jpeg")
                imageRect = myimage.get_rect()
                imageRect.x = j * imageRect.width + CELL_WIDTH
                imageRect.y = i * imageRect.height + CELL_HEIGHT
                self.gameDisplay.blit(myimage, imageRect)

    def displayResult(self,type):
        if (type == "win"):
            pygame.draw.rect(self.gameDisplay, (0, 0, 150), (270, 150, 300, 170))
            font = pygame.font.SysFont("monospace", 40)
            label = font.render("You Win!!!", 1, (255, 255, 255))
            self.gameDisplay.blit(label, (350, 220))
        elif (type == "lose"):
            pygame.draw.rect(self.gameDisplay, (0, 100, 100), (270, 150, 300, 170))
            font = pygame.font.SysFont("monospace", 40)
            label = font.render("You Lose!!!", 1, (255, 255, 255))
            self.gameDisplay.blit(label, (350, 220))


    def checkEvent(self):
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                over = True
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_DOWN:
                    self.board.performMove('down')
                    self.clearText()

                if event.key == pygame.K_UP:
                    self.board.performMove('up')
                    self.clearText()

                if event.key == pygame.K_LEFT:
                    self.board.performMove('left')
                    self.clearText()

                if event.key == pygame.K_RIGHT:
                    self.board.performMove('right')
                    self.clearText()

                if event.key == pygame.K_SPACE:
                    doAI = False
                if event.key == pygame.K_RETURN or event.key == pygame.K_KP_ENTER:
                    doAI = True
                    self.board.toString()
            print(event)

    def start(self):
        while not self.over:
            pygame.draw.rect(self.gameDisplay, (0, 0, 0), (20, 20, 400, 100))
            label = self.font.render(self.score + str(self.board.getScore()), 1, (255, 255, 255))
            self.gameDisplay.blit(label, (20, 20))
            self.drawCell()
            if not self.board.isLose() or not self.board.isWin():
                self.checkEvent()

            elif self.board.isWin():
                self.displayResult("win")

            elif self.board.isLose():
                self.displayResult("lose")

            pygame.display.update()
            self.clock.tick(60)
        pygame.quit()
        quit()



Game()
