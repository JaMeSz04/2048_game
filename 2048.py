import pygame
from Colors import*

pygame.init()

gameDisplay = pygame.display.set_mode((800,600))
pygame.display.set_caption("2048 Game by ShubU")

clock = pygame.time.Clock()

over = False
while not over:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            over = True
        print(event)


    pygame.display.update()
    clock.tick(60)

pygame.quit()
quit()
