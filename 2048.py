import pygame
from pyswip import Prolog
from PrologConnecter import Connector
from workk import*



score = "Score : "
board = Board()

pygame.init()

CELL_WIDTH = 100
CELL_HEIGHT = 100
CELL_MARGIN = 5

CELL_ASSETS = ['0', '2', '4', '8', '16', '32', '64', '128', '256', '512',
               '1024','2048','4096','8192']
MOVEMENT = ['up','down','left','right']

class Color:
    BLACK = (0, 0, 0)
    WHITE = (255, 255, 255)

gameDisplay = pygame.display.set_mode((800,600))
pygame.display.set_caption("2048 Game by NeamMan")

clock = pygame.time.Clock()

def clearText():
    label = font.render(score + str(board.getScore()), 1, (0, 0, 0))
    gameDisplay.blit(label, (20, 20))


over = False
doAI = False
prevMove = None

ai = Connector('gebWai.pl')
boardList = list()
boardList.append(board.board)
boardNum = 0
while not over:
    pygame.draw.rect(gameDisplay,(0,0,0),(20,20,400,100))
    font = pygame.font.SysFont("monospace", 28)
    label = font.render(score + str(board.getScore()), 1, (255,255,255))

    gameDisplay.blit(label, (20,20))


    for i in range(len(board.board)):
        for j in range(len(board.board)):
            myimage = pygame.image.load("assets/" + str(board.board[i][j]) + ".jpeg")
            imageRect = myimage.get_rect()
            imageRect.x = j * imageRect.width + 230
            imageRect.y = i * imageRect.height + 130
            gameDisplay.blit(myimage, imageRect)

    if not board.isLose() or not board.isWin():
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                over = True
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_DOWN:
                    board.performMove('down')
                    clearText()

                if event.key == pygame.K_UP:
                    board.performMove('up')
                    clearText()

                if event.key == pygame.K_LEFT:
                    #board.performMove('left')
                    boardNum -= 1
                    clearText()

                if event.key == pygame.K_RIGHT:
                    #board.performMove('right')
                    boardNum += 1
                    clearText()
                if event.key == pygame.K_RETURN or event.key == pygame.K_KP_ENTER:
                    doAI = True

            print(event)

        if doAI:
            moveDictList = ai.aiMove(board.board, 3)
            moveDict = moveDictList[0]
            actualMove = moveDict['Move']
            if actualMove == 'u':
                board.performMove('up')
            elif actualMove == 'd':
                board.performMove('down')
            elif actualMove == 'r':
                board.performMove('right')
            elif actualMove == 'l':
                board.performMove('left')
            # movement = ['up', 'down', 'left', 'right']
            # actions = board.getPredictAll(board.board)
            # scores = [board.solve(child,child, 4, False) for child in actions]
            # #print("SCORE : " + str(scores))
            # toMove = movement[scores.index(max(scores))]
            # #print("toMove : " + str(toMove))
            # #print("predicted : " + str(board.getPredictMove(toMove) == board.board))
            # while board.getPredictMove(toMove)[0] == board.board:
            #     movement.pop(scores.index(max(scores)))
            #     scores.remove(max(scores))
            #     if len(scores) == 0:
            #         break
            #     toMove = movement[scores.index(max(scores))]
            # prevMove = toMove
            # if len(scores) == 0:
            #     movement = ['up', 'down', 'left', 'right']
            #     for i in movement:
            #         board.performMove(i)
            # else:
            #     board.performMove(toMove)
            # movement = ['up', 'down', 'left', 'right']

    elif board.isWin():
        pygame.draw.rect(gameDisplay, (0, 0, 150), (270, 150, 300, 170))
        font = pygame.font.SysFont("monospace", 40)
        label = font.render("You Win!!!", 1, (255, 255, 255))
        gameDisplay.blit(label, (350, 220))

    elif board.isLose():
        pygame.draw.rect(gameDisplay, (0, 100, 100), (270, 150, 300, 170))
        font = pygame.font.SysFont("monospace", 40)
        label = font.render("You Lose!!!", 1, (255, 255, 255))
        gameDisplay.blit(label, (350, 220))

    pygame.display.update()
    clock.tick(60)

pygame.quit()
quit()
