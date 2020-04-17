import serial
from directkeys import PressKey, ReleaseKey, UP, DOWN
from time import sleep

s = serial.Serial('COM4')

fichier = open("data.txt", "r+")
fichier.truncate(0)
fichier.close()

def computeBrainData():
    fichier = open('data.txt', 'r+')
    data = fichier.read().split(",")[0:-1]
    print(data)
    delta = data[4]
    theta = data[5]
    lowAlpha = data[6]
    highAlpha = data[7]
    lowBeta = data[8]
    highBeta = data[9]
    avance = 0

    total = int(delta) + int(theta) + int(lowAlpha) + int(highAlpha) + int(lowBeta) + int(highBeta) 
    if total > 1000000:
        if avance == 0:
            avance = 1
        else :
            avance = 0
    if avance == 1 :
        print('Avance')
        PressKey(UP)
    else:
        print('Ralenti')
        ReleaseKey(UP)
    fichier.close()
    return


while(True):
    fichier = open("data.txt", "a")
    char = s.read().decode('utf-8')
    fichier.write(char)
    if char == "\n":
        computeBrainData()
        fichier.truncate(0)
    fichier.close()
    # sleep(0.0025)
