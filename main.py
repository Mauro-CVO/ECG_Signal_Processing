# Facultad de Ciencias
# Elaborado por: Mauro Cortés y Raul Rivas
# Con este codigo integramos las funciones para tomar las muestras
# y para eliminar los primeros 5 segundos de la medición

# Importamos la función de tomar muestra y
# eliminar los 5 segundos de la medición
from mediciones import ECG
from colchon import colchon


if __name__ == '__main__':
    # Asignamos el nombre a la medición
    title = './Mediciones/mediciones5.txt'
    # Inicializamos la función para tomar la muestra
    ECG(title)
    # Inicializamos la función para eliminar el colchon
    colchon(title)
