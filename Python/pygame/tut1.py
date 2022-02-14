import pygame
import time
pygame.init()

cur=1
screen = pygame.display.set_mode([1920, 1080])

running = True
while running:

    # Did the user click the window close button?
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Fill the background with white
    screen.fill((255, 255, 255))

    # Draw a solid blue circle in the center
    if( int(time.time()/cur)%2==0 ):
        pygame.draw.circle(screen, (0, 0, 0), (960, 540), 500)
    else:
        pygame.draw.rect(screen, (0, 0, 0), (480, 270, 960, 540), 0)
        

    # Flip the display
    pygame.display.flip()

# Done! Time to quit.
pygame.quit()
