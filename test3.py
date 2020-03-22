import serial
import pyautogui
from time import sleep

pyautogui.FAILSAFE = False
pyautogui.PAUSE = 0
s = serial.Serial('COM4')
screenWidth, screenHeight = pyautogui.size()
currentMouseX, currentMouseY = pyautogui.position()
fichier = open("data.txt", "r+")
fichier.truncate(0)
fichier.close()


def moveCursor():
    fichier = open('data.txt', 'r+')
    accelerations = fichier.read().split("|")[0:-1]
    accelerationX = accelerations[0]
    accelerationY = (int(accelerations[1])+19000)/35
    accelerationZ = (int(accelerations[2])+18000)/18
    print(accelerationZ, accelerationY)
    pyautogui.moveTo(int(accelerationZ), int(accelerationX))

   
    # print(int(accelerationZ))
    # print(int(accelerationX))
    # print(currentMouseX)
    # print(currentMouseY)

    fichier.close()
    return


while(True):
    fichier = open("data.txt", "a")
    char = s.read().decode('utf-8')
    fichier.write(char)
    if char == "\n":
        moveCursor()
        fichier.truncate(0)
    fichier.close()
    # sleep(0.0025)
