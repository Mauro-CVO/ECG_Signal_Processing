import numpy as np


def colchon(title):
    signal = []

    with open(title, 'r') as f:
        # lines = f.readlines()
        for x in f:
            x = x.replace('\n', '')
            if x == '':
                pass
            else:
                signal.append(float(x))

        f.close()
    # print(len(signal))

    signal = signal = np.array(signal)

    med = len(signal) - 6000
    # print(med)
    signal = signal[med:]

    # print(len(signal))

    with open(title, 'w') as f:
        # lines = f.readlines()
        for i in signal:
            f.write(str(i) + '\n')

        f.close()
