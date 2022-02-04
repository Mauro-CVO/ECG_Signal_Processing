# Facultad de Ciencias
# Elaborado por: Mauro Cortés y Raul Rivas
# Con este codigo obtenemos la medición

# Importamos los módulos necesarios
import serial
import time
import os

# Inicializamos la función


def ECG(title):

    # creamor el archivo donde se guardaran los datos
    mediciones = open(title, 'w')
    # Inicializamos comunicación serial con el microcontrolador
    ser = serial.Serial("COM5", 9600)
    ser.close()
    ser.open()
    print('Empezando...')
    # Espera de un segundo
    time.sleep(1)
    # Obtenemos el tiempo actual
    main = time.time()
    # Creamos un vector con 4 tiempos para especificar tiempos de carga
    t = [int(main)+15, int(main)+30, int(main)+45, int(main)+60]
    # Establecemos el tiempo final como el tiempo actual + 65
    end = main + 65

    # Ciclo para obtener los datos
    while main < end:
        # Obtiene el tiempo actual
        main = time.time()
        # Leemos los datos del ADC
        data = ser.readline()
        # Escribimos en el archivo lo que leimos del ADC
        mediciones.write(data.decode('utf-8'))
        # If statement para poner el progreso de la medición
        if int(main) == t[0]:
            print('25% completado')
        if int(main) == t[1]:
            print('50% completado')
        if int(main) == t[2]:
            print('75% completado')
        if int(main) == t[3]:
            print('99% completado')

    # Borramos la pantalla del CMD
    os.system('cls')
    # Imprime Medicion Completada
    print('Medicion Completada')
