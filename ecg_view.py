import numpy as np
import matplotlib.pyplot as plt

signal = []
title = './Mediciones/mediciones5.txt'

with open(title, 'r') as f:
    # lines = f.readlines()
    for x in f:
        x = x.replace('\n', '')
        if x == '':
            pass
        else:
            signal.append(float(x))

    f.close()

signal = np.array(signal)

med = len(signal) - 6000
# print(med)

signal = signal[med:]
# print(len(signal))

muestras1 = 500
muestras2 = 0
seg1 = 5
seg2 = 0

for i in range(12):
    signal1 = signal[muestras2:muestras1]
    muestras1 += 500
    muestras2 += 500

    time = np.linspace(seg2, seg1, len(signal1))
    seg2 += 5
    seg1 += 5

    plt.figure()
    plt.plot(time, signal1, color='blue', label="ECG")
    plt.xlabel("Tiempo [s]")
    plt.ylabel("Amplitud")
    plt.legend()
    plt.grid()
    plt.show()
