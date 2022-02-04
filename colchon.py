# Facultad de Ciencias
# Elaborado por: Mauro Cortés y Raul Rivas
# Con este codigo eliminamos los primeros 5 segundos de la medicion

# Importamos las librerias necesarios
import numpy as np

# Inicializamos la funcion


def colchon(title):

    # creamos un lista vacia
    signal = []

    # abrimos el archivo de las mediciones y lo guardamos en la lista signal
    with open(title, 'r') as f:
        # lines = f.readlines()
        for x in f:
            x = x.replace('\n', '')
            if x == '':
                pass
            else:
                signal.append(float(x))

        f.close()

    # Eliminamos los primeros 5 segundos de la medición
    signal = np.array(signal)
    med = len(signal) - 6000
    signal = signal[med:]

    # Reescribimos la nueva medicion en el archivo
    with open(title, 'w') as f:
        # lines = f.readlines()
        for i in signal:
            f.write(str(i) + '\n')

        f.close()
