import serial
import time
import os


def ECG(title):

    mediciones = open(title, 'w')
    ser = serial.Serial("COM5", 9600)
    ser.close()
    ser.open()
    print('Empezando...')
    time.sleep(1)
    main = time.time()
    t = [int(main)+15, int(main)+30, int(main)+45, int(main)+60]
    end = main + 65

    while main < end:
        main = time.time()
        data = ser.readline()
        mediciones.write(data.decode('utf-8'))
        if int(main) == t[0]:
            print('25% completado')
        if int(main) == t[1]:
            print('50% completado')
        if int(main) == t[2]:
            print('75% completado')
        if int(main) == t[3]:
            print('99% completado')

    os.system('cls')
    print('Medicion Completada')
