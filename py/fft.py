import numpy as np

a = np.arange(16)

afft = np.fft.fft(a)
affti = np.fft.fft(np.conj(afft))

print(a)
print(afft)
print(affti/16)