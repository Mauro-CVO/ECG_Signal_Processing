import serial
import time
import os

clearConsole(): lambda: os.system("cls")


def ECG(title):

    mediciones = open(title, 'w')
    ser = serial.Serial("COM5", 9600)
    ser.close()
    ser.open()
    time.sleep(1)
    start = time.time()
    main = time.time()
    end = main + 65
    print('Empazando...')

    while main < end:
        main = time.time()
        data = ser.readline()
        mediciones.write(data.decode('utf-8'))
        if main == start+15:
            clearConsole()
            print('25% completado')
        if main == start+30:
            clearConsole()
            print('50% completado')
        if main == start+45:
            clearConsole()
            print('75% completado')
        if main == start+15:
            clearConsole()
            print('99% completado')

    print('Medicion Completada')
