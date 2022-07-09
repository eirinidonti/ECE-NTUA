from matplotlib.ticker import StrMethodFormatter
import statistics
import numpy as np
import matplotlib.pyplot as plt
import scipy
import math
from scipy import signal
import binascii
from scipy.io import wavfile

# EIRINI DONTI 03119839

# EXERCISE 1

A = 4 # V amplitude
fm = 2000 # Hz frequency (Eirini Donti)
T = 1/fm
t = np.linspace(0, 4*T, 10000)
y = A * signal.sawtooth(2 * np.pi * fm * t, 0.5) # triangle wave
plt.plot(t, y)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Signal for sampling")
ax = plt.gca() # fix x axis scale
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# a
fs1 = 30*fm
fs2 = 50*fm

# (i)
Ts1 = 1/fs1 # sampling with fs1
t1 = np.arange(0, 4*T, Ts1)
y1 = A * signal.sawtooth(2 * np.pi * fm * t1, 0.5)
plt.stem(t1,y1)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 1 (fs1 = 30fm)")
ax = plt.gca() # fix x axis scale
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# (ii)
Ts2 = 1/fs2 # sampling with fs2
t2 = np.arange(0, 4*T, Ts2)
y2 = A * signal.sawtooth(2 * np.pi * fm * t2, 0.5)
plt.stem(t2,y2)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 2 (fs2 = 50fm)")
ax = plt.gca()
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# (iii)
t1 = np.arange(0, 4*T, Ts1) # plot both samples
y1 = A * signal.sawtooth(2 * np.pi * fm * t1, 0.5)
plt.stem(t1,y1, linefmt = 'red', markerfmt = 'rD')

t2 = np.arange(0, 4*T, Ts2)
y2 = A * signal.sawtooth(2 * np.pi * fm * t2, 0.5)
plt.stem(t2, y2, linefmt = 'blue', markerfmt = 'bD')
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 1 & 2")
ax = plt.gca() # fix x axis scale
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# b
fs3 = 4*fm # sampling with fs3 = 4fm
Ts3 = 1/fs3
t3 = np.arange(0, 4*T, Ts3)
y3 = A * signal.sawtooth(2 * np.pi * fm * t3, 0.5)
plt.stem(t3,y3)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 3 (fs3 = 4fm)")
ax = plt.gca() # fix x axis scale
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

#c
A = 1 # V amplitude

#(i)
t = np.linspace(0, 4*T, 10000)
z = A*np.sin(2*np.pi*fm*t)

# a
# (i)
Ts1 = 1/fs1 # sampling with fs1
t1 = np.arange(0, 4*T, Ts1)
z1 = A*np.sin(2*np.pi*fm*t1)
plt.stem(t1,z1)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 1 (fs1 = 30fm)")
ax = plt.gca() # fix x axis scale
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# (ii)
Ts2 = 1/fs2 # sampling with fs2
t2 = np.arange(0, 4*T, Ts2)
z2 = A*np.sin(2*np.pi*fm*t2)
plt.stem(t2,z2)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 2 (fs2 = 50fm)")
ax = plt.gca() # fix x axis scale
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# (iii)
t1 = np.arange(0, 4*T, Ts1) # plot both samples
z1 = A*np.sin(2*np.pi*fm*t1)
plt.stem(t1,z1, linefmt = 'red', markerfmt = 'rD')

t2 = np.arange(0, 4*T, Ts2)
z2 = A*np.sin(2*np.pi*fm*t2)
plt.stem(t2,z2, linefmt = 'blue', markerfmt = 'bD')

plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 1 & 2")
ax = plt.gca() # fix x axis scale
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# b
fs3 = 4*fm # sampling with fs3 = 4fm
Ts3 = 1/fs3
t3 = np.arange(0, 4*T, Ts3)
y3 = A * signal.sawtooth(2 * np.pi * fm * t3, 0.5)
plt.stem(t3,y3)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 3 (fs = 4fm)")
ax = plt.gca() # fix x axis scale
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# (ii)
L = 1000 # Hz
t = np.linspace(0, 4*T, 10000)
q = A*np.sin(2*np.pi*fm*t) + A*np.sin(2*np.pi*(fm + L)*t)

#a

# (i)
Ts1 = 1/fs1 # sampling with fs1
t1 = np.arange(0, T, Ts1)
q1 = A*np.sin(2*np.pi*fm*t1) + A*np.sin(2*np.pi*(fm + L)*t1)
plt.stem(t1,q1)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 1 (fs1 = 30fm)")
ax = plt.gca() # fix x axis scale
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# (ii)
Ts2 = 1/fs2 # sampling with fs2
t2 = np.arange(0, T, Ts2)
q2 = A*np.sin(2*np.pi*fm*t2) + A*np.sin(2*np.pi*(fm + L)*t2)
plt.stem(t2,q2)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 2 (fs2 = 50fm)")
ax = plt.gca() #fix x axis scale
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# (iii)
t1 = np.arange(0, T, Ts1) # plot both samples
q1 = A*np.sin(2*np.pi*fm*t1) + A*np.sin(2*np.pi*(fm + L)*t1)
plt.stem(t1,q1, linefmt = 'red', markerfmt = 'rD')

t2 = np.arange(0, T, Ts2)
q2 = A*np.sin(2*np.pi*fm*t2) + A*np.sin(2*np.pi*(fm + L)*t2)
plt.stem(t2,q2, linefmt = 'blue', markerfmt = 'bD')

plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 1 & 2")
ax = plt.gca() # fix x axis scale
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# b
fs3 = 4*fm # sampling with fs3 = 4fm
Ts3 = 1/fs3
t3 = np.arange(0, T, Ts3)
q3 = A*np.sin(2*np.pi*fm*t3) + A*np.sin(2*np.pi*(fm + L)*t3)
plt.stem(t3,q3)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 3 (fs = 4fm)")
ax = plt.gca() # fix x axis scale
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# EXERCISE 2

# a
fm = 2000  # Hz
fs1 = 30*fm
T = 1/fm
A = 4 # V amplitude
Ts1 = 1/fs1  # sampling with fs1
t1 = np.arange(0, 4*T, Ts1)
y1 = A * signal.sawtooth(2 * np.pi * fm * t1, 0.5)

# a
bits = 4  # number of bits that will be used
levels = 2**bits
D = (2*A)/levels  # A is the highest magnitude

fig, ax = plt.subplots()

ax.yaxis.set_major_formatter(StrMethodFormatter("{x:04b}"))
ax.yaxis.set_ticks(np.arange(-100, 100, 1))

quant_signal = np.round(y1/D)*D

plt.stem(t1, quant_signal)
plt.xlabel("Time [sec]")
plt.ylabel("Levels (Gray Code)")
plt.title("Signal after quantization")
ax = plt.gca() # fix x axis scale
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# b
error = np.abs(y1 - quant_signal)  # quantization error

# (i)
error_first10 = error[0:10]

s10 = statistics.stdev(error_first10)
s10_2 = statistics.variance(error_first10)
print("The standard deviation for the first 10 samples is: ", s10)  # standard deviation for the first 10 samples

# (ii)
error_first20 = error[0:20]

s20 = statistics.stdev(error_first20)
s20_2 = statistics.variance(error_first20)

print("The standard deviation for the first 20 samples is: ", s20)  # standard deviation for the first 20 samples

# (iii)
error_quant = (1/3)*pow(A, 2)*pow(2, -2*bits) # standard deviation of quantization error
P_mean_30 = (1/30)*sum(map(lambda x: x*x, y1[0:30]))  # mean power of signal y1

SNR_10 = P_mean_30 / s10_2  # SNR for 10 samples # SNRq = P/(s^2)
print('SNR for 10 samples : ', SNR_10)
SNR_20 = P_mean_30 / s20_2  # SNR for 20 samples
print('SNR for 20 samples : ', SNR_20)

SNR_theor = P_mean_30 /error_quant  # SNR for theoretical value
print('SNR for theoretical : ', SNR_theor)

#c

def gray_code(n_bits):
    gray_arr = list()
    gray_arr.append("0")
    gray_arr.append("1")
    i = 2
    j = 0
    while(True):
        if i>=1 << n_bits:
            break
        for j in range(i - 1, -1, -1):
            gray_arr.append(gray_arr[j])
        for j in range(i):
            gray_arr[j] = "0" + gray_arr[j]
        for j in range(i, 2 * i):
            gray_arr[j] = "1" + gray_arr[j]
        i = i << 1

    return gray_arr

gray_code_2 = gray_code(bits)

Bitstream = ''  # bit stream of output
for i in range(0, 30):
    Bitstream += gray_code_2[int(quant_signal[i]+levels/2)]


samples_per_bit = 100
polar_rz = []
for i in range(0, len(Bitstream)):
    for j in range(0, samples_per_bit):
        polar_rz.append(int(Bitstream[i]))

t_bit_30 = np.linspace(0, 0.001*bits*30, samples_per_bit*bits*30, endpoint=False)
plt.plot(t_bit_30, fm/1000*signal.square(1*math.pi*t_bit_30, duty=polar_rz[0:samples_per_bit*bits*30]), label='POLAR RZ')
plt.title('Bit stream of quantized signal (fs1=30fm)')
plt.xlabel('Time [sec]')
plt.ylabel('Amplitude [V]')
plt.grid()
plt.xlim(0,0.12)
plt.show()

# EXERCISE 3

Abit = 2 # Volts Amplitude
Tb = 0.25 # sec bit duration
fm = 2000 #Hz
randbits = 36 # random bits

rand_bits = np.random.randint(2, size=(randbits)) # requested bit ganerator
#print(rand_bits)

#b

rand_bits_linspace = []
samples = 100 # samples per bit

for i in range(0, len(rand_bits)):
    for j in range(0, samples):
        rand_bits_linspace.append(rand_bits[i])

t_randbits = np.linspace(0, Tb * randbits, randbits * samples)
y_randbits = Abit * signal.square(2 * math.pi * t_randbits, duty=rand_bits_linspace[0:randbits * samples])
plt.plot(t_randbits, y_randbits) #Β-PAM modulation of bit sequence
plt.grid()
plt.title('B-PAM modulation')
plt.xlabel('Time (sec)')
plt.ylabel('Amplitude (V)')
plt.show()

#c

Eb = pow(Abit, 2) * Tb
xbpam = [-math.sqrt(Eb), math.sqrt(Eb)]
ybpam = [0, 0]
plt.scatter(xbpam, ybpam) #Constellation diagram of B-PAM signal (without AWGN)
plt.ylim([-0.5, 0.5])
plt.grid()
plt.title('Constellation of B-PAM signal')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.show()

#d

def SNR_linear(snr_ratio):
   return 10**(snr_ratio / 10) #SNR linear scale function

L5 = Eb / SNR_linear(5)  #dB to linear scale

#Eb/N0 = 5 dB
awgn5 = np.random.normal(0, np.sqrt(L5), 2 * randbits * samples).view(np.complex128) #complex awgn (5dB)
plt.subplot(3, 1, 2)
plt.plot(t_randbits, y_randbits + awgn5.real, label='Eb/N0 = 5 dB')
plt.grid()
plt.title('Signal with Eb/N0 = 5 dB')
plt.ylabel('Amplitude (V)')
plt.legend(loc='upper right')

L15 = Eb / SNR_linear(15) #dB to linear scale

#Eb/N0 = 15 dB
awgn15 = np.random.normal(0, np.sqrt(L15), 2 * randbits * samples).view(np.complex128) #complex awgn (15dB)
plt.subplot(3, 1, 3)
plt.plot(t_randbits, y_randbits + awgn15.real, label='Eb/N0 = 15 dB')
plt.grid()
plt.title('Signal with Eb/N0 = 15 dB')
plt.xlabel('Time (sec)')
plt.ylabel('Amplitude (V)')
plt.legend(loc='upper right')

#B-PAM signal from previous
plt.subplot(3, 1, 1)
plt.plot(t_randbits, y_randbits, label='B-PAM')
plt.grid()
plt.title('B-PAM modulation of generated bits')
plt.ylabel('Amplitude (V)')
plt.legend(loc='upper right')
plt.subplots_adjust(hspace=0.75) # space between subplots
plt.show()

#e

#Constellation diagram for Eb/N0 = 5 dB
x_bpam_with_awgn5 = (y_randbits[::1] + awgn5.real[::1]) * math.sqrt(Tb)
y_bpam_with_awgn5 = (awgn5.imag[::1]) * math.sqrt(Tb)

plt.subplot(3, 1, 1)
plt.scatter(x_bpam_with_awgn5, y_bpam_with_awgn5, s=1, label='Eb/N0 = 5 dB')
plt.ylim([-1, 1])
plt.grid()
plt.title('Constellation of B-PAM')
plt.legend(loc='upper left')
plt.ylabel('Quadrature')

#Constellation diagram for Eb/N0 = 15 dB
x_bpam_with_awgn15 = (y_randbits[::1] + awgn15.real[::1]) * math.sqrt(Tb)
y_bpam_with_awgn15 = (awgn15.imag[::1]) * math.sqrt(Tb)

plt.subplot(2, 1, 2)
plt.scatter(x_bpam_with_awgn15, y_bpam_with_awgn15, s=1, label='Eb/N0 = 15 dB')
plt.ylim([-0.4, 0.4])
plt.grid()
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.legend(loc='upper left')
plt.show()

# z

randbits2 = 10 ** 6
rand_bits_2 = np.random.randint(2, size=(randbits2)) #random bits generated

rand_bits2_mod = rand_bits_2 * 2 * Abit - Abit
tBER = np.arange(0, 16)

# Experimental Plot
No_experimental = []; awgn_experimental = []; BER_experimental = []
for i in tBER:
    No_experimental.append(Eb / SNR_linear(i))
    awgn_experimental.append(np.random.normal(0, np.sqrt(No_experimental[i]), 2 * randbits2).view(np.complex128)) # awgn noise
    output_sign2 = rand_bits2_mod + awgn_experimental[i].real # noise added to initial signal
    received_sign2 = (output_sign2 >= 0).astype(int) #de-noise
    BER_experimental.append(np.sum(received_sign2 != rand_bits_2) / randbits2) # BER calculation

# Theoretical Plot
def q_bpam(a):
    return (1.0/math.sqrt(2*math.pi))*scipy.integrate.quad(lambda x: math.exp(-(x**2)/2), a, pow(10,2))[0]

BER_theoretical = []
for i in tBER:
    BER_theoretical.append(q_bpam(np.sqrt(2 * SNR_linear(i))))

plt.semilogy(tBER, BER_experimental, color='g', marker='D', markersize=2, linestyle='', label='Experimental BER') # log scale in y axis
plt.semilogy(tBER, BER_theoretical, color='r',marker='', linestyle='dotted', label='Theoretical BER') # log scale in y axis
plt.title('Experimental & Theoretical BER')
plt.xlabel('Eb/N0 (dB)')
plt.ylabel('BER')
plt.grid()
plt.legend(loc='upper right')
plt.show()


# EXERCISE 4

#a

#Constellation

qpsk_num_symbols = 100
qpsk_constellation_size = math.sqrt(Eb) #size of qpsk constellation
qpsk_points = np.random.randint(0, 4, qpsk_num_symbols) # 4 points generated
qpsk_degrees = qpsk_points * 360 / 4.0 + 45 # degrees (K*π/4) K = 0,1,...
qpsk_position = qpsk_degrees * np.pi / 180.0 # position for each point
qpsk_symbols = qpsk_constellation_size * np.cos(qpsk_position) + qpsk_constellation_size * 1j * np.sin(qpsk_position) # complex number
plt.plot(np.real(qpsk_symbols), np.imag(qpsk_symbols), '.')
plt.grid()
plt.xlim(-qpsk_constellation_size - 1, qpsk_constellation_size + 1)
plt.ylim(-qpsk_constellation_size - 1, qpsk_constellation_size + 1)
plt.title('Constellation of QPSK [($π$/4) GRAY]')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.show()

#b

#Constellation

#NOISE (5dB)
awgn5 = np.random.normal(0, np.sqrt(L5), 2 * qpsk_num_symbols).view(np.complex128) #complex AWGN (5dB)
qpsk5_points = qpsk_symbols + awgn5 * math.sqrt(Tb)
plt.plot(np.real(qpsk5_points), np.imag(qpsk5_points), '.')
plt.grid()
plt.title('Constellation with noise Eb/N0 = 5 dB')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.show()

#NOISE (15dB)
awgn15 = np.random.normal(0, np.sqrt(L15), 2 * qpsk_num_symbols).view(np.complex128) #complex AWGN (15dB)
qpsk15_points = qpsk_symbols + awgn15 * math.sqrt(Tb)
plt.plot(np.real(qpsk15_points), np.imag(qpsk15_points), '.')
plt.grid()
plt.title('Constellation with noise Eb/N0 = 15 dB')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.show()


#c

randbits_4 = 10 ** 5 #number of bits genarated
rand_bits4 = np.random.randint(2, size=(randbits_4)) #random bits generated (array)
rand_bits4_string = ''.join([str(i) for i in rand_bits4]) # resulting string in random array of bits

# Experimental Plot
rand_bits_qpsk4 = []
for i in range(0, len(rand_bits4_string), 2):
    x = rand_bits4_string[i] + rand_bits4_string[i + 1]
    if (x=='00'):
        rand_bits_qpsk4.append(0)
    elif (x=='01'):
        rand_bits_qpsk4.append(1)
    elif (x=='11'):
        rand_bits_qpsk4.append(2)
    elif (x=='10'):
        rand_bits_qpsk4.append(3)

qpsk_experimental_degrees = np.array(rand_bits_qpsk4) * 360 / 4.0 + 45  # degrees (K*π/4) K = 0,1,2,...
qpsk_experimental_position = qpsk_experimental_degrees * np.pi / 180.0 # position for each point
qpsk_experimental_symbols = qpsk_constellation_size * np.cos(qpsk_experimental_position) + qpsk_constellation_size * 1j * np.sin(qpsk_experimental_position) # complex number

awgn_experimental4 = []; output_sign4 = []; output_sign_4position = []; BER_experimental4 = []

for i in tBER:
    # Generate Noise
    awgn_experimental4.append(np.random.normal(0, np.sqrt(No_experimental[i] / 2), 2 * randbits_4 // 2).view(np.complex128)) #list of awgn noise for each SNR ratio (2* because of complex numbers , /2 because of qpsk modulation)
    output_sign4.append(qpsk_experimental_symbols + awgn_experimental4[i])

    # Reconstruct signal
    output_sign_4position.append(np.arctan2(np.imag(output_sign4[i]), np.real(output_sign4[i])))
    received_sign4 = '' #reconstructed binary signal to string
    for j in output_sign_4position[i]:
        if (j>=0 and j<np.pi/2):
            received_sign4 += '00'
        elif (j>=np.pi/2 and j<np.pi):
            received_sign4 += '01'
        elif (j>=-np.pi and j<-np.pi/2):
            received_sign4 += '11'
        elif (j>=-np.pi/2 and j<0):
            received_sign4 += '10'

    #BER Calculation
    error_bits = 0
    for j in range(0, len(received_sign4) - 1):
        if (received_sign4[j] != rand_bits4_string[j]):
            error_bits += 1
    BER_experimental4.append(error_bits / len(received_sign4))

#Theoretical Plot
BER_theor_4 = []
for i in tBER:
    BER_theor_4.append(q_bpam(np.sqrt(SNR_linear(i))))

plt.semilogy(tBER, BER_experimental4, color='r', marker='D', markersize=2, linestyle='', label='Experimental QPSK')
plt.semilogy(tBER, BER_theor_4, marker='', linestyle='dotted', linewidth=1, label='Theoretical QPSK')
plt.semilogy(tBER, BER_experimental, color='g', marker='D', markersize=2, linestyle='', label='Experimental BPSK')
plt.title('Experimental & Theoretical BER')
plt.xlabel('Eb/N0 (dB)')
plt.ylabel('BER')
plt.legend(loc='upper right')
plt.grid()
plt.show()


#d

file_name = 'rice_even.txt' # 2 = even number

#(i)
#ASCII to Binary
def text_bits(text, encoding='utf-8', errors='surrogatepass'):
    bits = bin(int(binascii.hexlify(text.encode(encoding, errors)), 16))[2:]
    return bits.zfill(8 * ((len(bits) + 7) // 8))

file = open(file_name, 'r')

file_string = ''
for i in file:
    file_string += i

file_ascii = []
for i in file_string:
    file_ascii.append(ord(i))

#Text converted to binary
file_binary = text_bits(file_string)

#(ii)
t_ascii = np.arange(0, len(file_ascii))
plt.plot(t_ascii, file_ascii, color ='k', linestyle='-', linewidth=0.75, label='Signal (txt)')
plt.title("8-bit Quantization")
plt.xlabel('Characters')
plt.ylabel('ASCII')
plt.legend(loc='upper right')
plt.xlim(0,500)
plt.ylim(31, 120)
plt.show()

#(iii)
file_bin_qpsk = []
for i in range(0, len(file_binary), 2):
    x = file_binary[i] + file_binary[i + 1]
    if (x=='00'):
        file_bin_qpsk.append(0)
    elif (x=='01'):
        file_bin_qpsk.append(1)
    elif (x=='11'):
        file_bin_qpsk.append(2)
    elif (x=='10'):
        file_bin_qpsk.append(3)

qpsk_text_degrees = np.array(file_bin_qpsk) * 360 / 4.0 # degrees (K*pi/2) K = 0,1,2,...
qpsk_text_position = qpsk_text_degrees * np.pi / 180.0 #position for each point
qpsk_text_symbols = 1*np.cos(qpsk_text_position) + 1*1j * np.sin(qpsk_text_position) # complex number

plt.plot(np.real(qpsk_text_symbols), np.imag(qpsk_text_symbols), '.')
plt.grid()
plt.xlim(-qpsk_constellation_size - 1, qpsk_constellation_size + 1)
plt.ylim(-qpsk_constellation_size - 1, qpsk_constellation_size + 1)
plt.title('Constellation of QPSK (text)')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.show()

#(iv)
Eb_text = pow(1, 2) * Tb
L5_text = Eb_text / SNR_linear(5)
L15_text = Eb_text / SNR_linear(15)

#AWGN NOISE Es/N0 = 5dB
text_awgn5 = np.random.normal(0, np.sqrt(L5_text), 2 * len(file_bin_qpsk)).view(np.complex128) #AWGN (5dB)
qpsk5_points = qpsk_text_symbols + text_awgn5 #signal + noise(5dB)

#AWGN NOISE Es/N0 = 15dB
text_awgn15 = np.random.normal(0, np.sqrt(L15_text), 2 * len(file_bin_qpsk)).view(np.complex128) #AWGN (15dB)
qpsk15_points = qpsk_text_symbols + text_awgn15 #signal + noise(15dB)

#(v)
#Signal Reconstruction

#Es/N0 = 5dB
qpsk_reconstruction_position5 = np.arctan2(np.imag(qpsk5_points), np.real(qpsk5_points))
file_bin_reconstruct_5 = ''
for i in qpsk_reconstruction_position5:
    if (i>=-np.pi/4 and i<np.pi/4):
        file_bin_reconstruct_5 += '00'
    elif (i>=np.pi/4 and i<np.pi*3/4):
        file_bin_reconstruct_5 += '01'
    elif (i>=np.pi*3/4 or i<-np.pi*3/4):
        file_bin_reconstruct_5 += '11'
    elif (i>=-np.pi*3/4 and i<-np.pi/4):
        file_bin_reconstruct_5 += '10'

#Es/N0 = 15dB
qpsk_reconstruction_position15 = np.arctan2(np.imag(qpsk15_points), np.real(qpsk15_points))
file_bin_reconstruct_15 = ''
for i in qpsk_reconstruction_position15:
    if (i>=-np.pi/4 and i<np.pi/4):
        file_bin_reconstruct_15 += '00'
    elif (i>=np.pi/4 and i<np.pi*3/4):
        file_bin_reconstruct_15 += '01'
    elif (i>=np.pi*3/4 or i<-np.pi*3/4):
        file_bin_reconstruct_15 += '11'
    elif (i>=-np.pi*3/4 and i<-np.pi/4):
        file_bin_reconstruct_15 += '10'

#Constellation Plot

#Es/N0 = 5dB
plt.plot(np.real(qpsk5_points), np.imag(qpsk5_points), '.')
plt.grid()
plt.title('QPSK Constellation for Es/N0 = 5 dB')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.show()

#Es/N0 = 15dB
plt.plot(np.real(qpsk15_points), np.imag(qpsk15_points), '.')
plt.grid()
plt.title('QPSK Constellation for Es/N0 = 15 dB')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.show()

#(vi)
#Experimental BER Calculator with Es/N0 = 5 & 15 dB
counter_BER5 = 0.0
counter_BER15 = 0.0
for i in range(0, len(file_binary) - 1):
    if (file_binary[i] != file_bin_reconstruct_5[i]):
        counter_BER5 += 1
    if (file_binary[i] != file_bin_reconstruct_15[i]):
        counter_BER15 += 1

BER_experimental5 = counter_BER5 / len(file_binary)
BER_experimental15 = counter_BER15 / len(file_binary)

#Theoretical BER Calculator with Es/N0 = 5 & 15 dB
BER_theorerical5 = q_bpam(np.sqrt(SNR_linear(5)))
BER_theoretical15 = q_bpam(np.sqrt(SNR_linear(15)))

print('Experimental BER (Noise 5 dB) :', str(BER_experimental5))
print('Theoretical BER (Noise 5 dB) :', str(BER_theorerical5))
print('Experimental BER (Noise 15 dB) :', str(BER_experimental15))
print('Theoretical BER (Noise 15 dB) :', str(BER_theoretical15))

#(vii)

text_export_name_5dB = 'rice_even_export5dB'
text_export_name_15dB = 'rice_even_export15dB'

# File Reconstruction
#Es/N0 = 5 dB
file_binary_reconstruction5 = [file_bin_reconstruct_5[i:i + 8] for i in range(0, len(file_bin_reconstruct_5), 8)]
file_string_reconstruction5 = ''
for i in file_binary_reconstruction5:
    file_string_reconstruction5 += chr(int(i, 2))
new_file = open(text_export_name_5dB+'.txt', 'w', encoding='utf-8')
new_file.write(file_string_reconstruction5)
new_file.close()

#Es/N0 = 15 dB
file_binary_reconstruction15 = [file_bin_reconstruct_15[i:i + 8] for i in range(0, len(file_bin_reconstruct_15), 8)]
file_string_reconstruction15 = ''
for i in file_binary_reconstruction15:
    file_string_reconstruction15 += chr(int(i, 2))
new_file = open(text_export_name_15dB+'.txt', 'w', encoding='utf-8')
new_file.write(file_string_reconstruction15)
new_file.close()

# EXERCISE 5

#Generate Gray code
def gray_code(bits):
    gray_array = list()
    gray_array.append("0")
    gray_array.append("1")
    i = 2
    j = 0
    while(True):
        if i>=1 << bits:
            break
        for j in range(i - 1, -1, -1):
            gray_array.append(gray_array[j])
        for j in range(i):
            gray_array[j] = "0" + gray_array[j]
        for j in range(i, 2 * i):
            gray_array[j] = "1" + gray_array[j]
        i = i << 1

    return gray_array

fm = 2000 # Hz
Abit = 2 # V - bit stream Amplitude
Tb = 0.25 # sec - bit duration
Eb = pow(Abit, 2) * Tb
qpsk_constellation_size = math.sqrt(Eb) #size of qpsk constellation

# a
audio_signal = 'soundfile2_lab2.wav' # 2 = even number
audio_samplerate, audio_file = wavfile.read(audio_signal)
plt.plot(audio_file)
plt.title('Audio file') # plot audio wave
plt.xlabel("time (s)")
plt.ylabel("Amplitude")
plt.show()

# b
quantization_bits = 8
quantization_levels = 2 ** quantization_bits
max_audio = max(abs(audio_file))
audio_delta = (2*max_audio)/(quantization_levels - 1)
quant_audio = np.copy(audio_file)
for i in range(0, audio_file.size):
    quant_audio[i] = int(math.floor(round(audio_file[i], 4) / audio_delta)) #quantized levels

gray_code_ex5 = gray_code(quantization_bits)
plt.plot(quant_audio)
plt.title('Quantized signal with mid riser (8 bits)')
plt.xlabel('Time (s)')
plt.ylabel("Quantized value")
plt.show()

# c
# Convert audio file to binary

audio_binary = ''
for i in range(0, audio_file.size):
    audio_binary += gray_code_ex5[int(quant_audio[i] + quantization_levels / 2)]

audio_binary_qpsk = []
for i in range(0, len(audio_binary), 2):
    x = audio_binary[i] + audio_binary[i + 1]
    if (x=='00'):
        audio_binary_qpsk.append(0)
    elif (x=='01'):
        audio_binary_qpsk.append(1)
    elif (x=='11'):
        audio_binary_qpsk.append(2)
    elif (x=='10'):
        audio_binary_qpsk.append(3)

qpsk_degrees = np.array(audio_binary_qpsk) * 360 / 4.0  # i = i + 90 deg
qpsk_rad = qpsk_degrees * np.pi / 180.0  # convert degrees to rad
qpsk = 1*np.cos(qpsk_rad) + 1*1j * np.sin(qpsk_rad)  # create te complex number
plt.plot(np.real(qpsk), np.imag(qpsk), '.')
plt.xlim(-qpsk_constellation_size -1, qpsk_constellation_size + 1)
plt.ylim(-qpsk_constellation_size -1, qpsk_constellation_size + 1)
plt.title('Quantized signal with QPSK modulation ')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.grid()
plt.show()

# d
#SNR to linear scale function
def SNR_linear(snr):
    return 10**(snr / 10)

Eb_audio = pow(1, 2) * Tb
No4 = Eb_audio / SNR_linear(4)
No14 = Eb_audio / SNR_linear(14)

# For 4dB
awgn_4 = np.random.normal(0, np.sqrt(No4), 2 * len(audio_binary_qpsk)).view(np.complex128) #complex awgn (5dB)
qpsk_4 = qpsk + awgn_4

# For 14dB
awgn_14 = np.random.normal(0, np.sqrt(No14), 2 * len(audio_binary_qpsk)).view(np.complex128) #complex awgn (15dB)
qpsk_14 = qpsk + awgn_14

# e
# For 4dB
plt.plot(np.real(qpsk_4), np.imag(qpsk_4), '.')
plt.title('Constellation for Es/N0 = 4dB')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.grid()
plt.show()

# For 14dB
plt.plot(np.real(qpsk_14), np.imag(qpsk_14), '.')
plt.title('Constellation for Es/N0 = 14dB')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.grid()
plt.show()

# Reconstruct signals in order to calculate the possibility of BER

# For SNR = 4dB
rec_4 = np.arctan2(np.imag(qpsk_4), np.real(qpsk_4))
binary_rec_4 = ''
for i in rec_4:
    if i>=-np.pi/4 and i<np.pi/4:
        binary_rec_4 += '00'
    elif i>=np.pi/4 and i<np.pi*3/4:
        binary_rec_4 += '01'
    elif i>=np.pi*3/4 or i<-np.pi*3/4:
        binary_rec_4 += '11'
    elif i>=-np.pi*3/4 and i<-np.pi/4:
        binary_rec_4 += '10'

# For SNR = 14dB
rec_14 = np.arctan2(np.imag(qpsk_14), np.real(qpsk_4))
binary_rec_14 = ''
for i in rec_14:
    if i>=-np.pi/4 and i<np.pi/4:
        binary_rec_14 += '00'
    elif i>=np.pi/4 and i<np.pi*3/4:
        binary_rec_14 += '01'
    elif i>=np.pi*3/4 or i<-np.pi*3/4:
        binary_rec_14 += '11'
    elif i>=-np.pi*3/4 and i<-np.pi/4:
        binary_rec_14 += '10'

# st
# Experimental BER
count4 = 0.0
count14 = 0.0
for i in range(0, len(audio_binary) - 1):
    if audio_binary[i] != binary_rec_4[i]:
        count4 += 1
    if audio_binary[i] != binary_rec_14[i]:
        count14 += 1

ex_BER4 = count4 / len(audio_binary)
print('The experimental BER for SNR=4dB is equal to : ', ex_BER4)

ex_BER14 = count14 / len(audio_binary)
print('The experimental BER for SNR=14dB is equal to : ', ex_BER14)


# Theoritical BER
def q_bpam(a):
    return (1.0/math.sqrt(2*math.pi))*scipy.integrate.quad(lambda x: math.exp(-(x**2)/2), a, pow(10,2))[0]

th_BER4 = q_bpam(np.sqrt(SNR_linear(4)))
print('The theoretical BER for SNR=4dB is equal to : ', th_BER4 )

th_BER14 = q_bpam(np.sqrt(SNR_linear(14)))
print('The theoretical BER for SNR=14dB is equal to : ', th_BER14)

# z
audio_exp4dB = 'soundfile2_export_4dB'
audio_exp14dB = 'soundfile2_export_14dB'

# We reconstruct the signals

# For SNR = 4dB
audio_binary_rec_array4 = [binary_rec_4[i:i+8] for i in range(0, len(binary_rec_4), 8)]  # create list elements with 8 bits
audio_new_rec4 = []  # reconstructed signal
audio_quant_rec4 = []  # new levels

for i in range (0, len(audio_binary_rec_array4)):
    audio_quant_rec4.append(gray_code_ex5.index(audio_binary_rec_array4[i]) - quantization_levels/2)
    audio_new_rec4.append(audio_delta*(audio_quant_rec4[i]) + audio_delta/2)

wavfile.write(audio_exp4dB+'.wav', audio_samplerate, np.array(audio_new_rec4, dtype=np.uint8))


# For SNR = 14dB
audio_binary_rec_array14 = [binary_rec_14[i:i + 8] for i in range(0, len(binary_rec_14), 8)]  # create list elements with 8 bits
audio_new_rec14 = []  # reconstructed signal
audio_quant_rec14 = []  # new levels

for i in range (0, len(audio_binary_rec_array14)):
    audio_quant_rec14.append(gray_code_ex5.index(audio_binary_rec_array14[i]) - quantization_levels/2)
    audio_new_rec14.append(audio_delta*(audio_quant_rec14[i]) + audio_delta/2)

wavfile.write(audio_exp14dB+'.wav', audio_samplerate, np.array(audio_new_rec14, dtype=np.uint8))

# VASILEIA NTALIANH 03119846

# EXERCISE 1

A = 4  # V amplitude
fm = 9000  # Hz frequency (Vasileia Ntaliani - 3 last digits 846)
T = 1/fm
t = np.linspace(0, 4*T, 10000)
y = A * signal.sawtooth(2 * np.pi * fm * t, 0.5) # triangle wave
plt.plot(t, y)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Signal for sampling")
ax = plt.gca()
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# a

fs1 = 30*fm
fs2 = 50*fm

# (i)

Ts1 = 1/fs1  # sampling with fs1
t1 = np.arange(0, 4*T, Ts1)
y1 = A * signal.sawtooth(2 * np.pi * fm * t1, 0.5)
plt.stem(t1, y1)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 1 (fs1 = 30fm)")
ax = plt.gca()
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()


# (ii)

Ts2 = 1/fs2  # sampling with fs2
t2 = np.arange(0, 4*T, Ts2)
y2 = A * signal.sawtooth(2 * np.pi * fm * t2, 0.5)
plt.stem(t2,y2)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 2 (fs2 = 50fm)")
ax = plt.gca()
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# (iii)

t1 = np.arange(0, 4*T, Ts1)
y1 = A * signal.sawtooth(2 * np.pi * fm * t1, 0.5)
plt.stem(t1,y1, linefmt = 'red', markerfmt = 'rD')

t2 = np.arange(0, 4*T, Ts2)
y2 = A * signal.sawtooth(2 * np.pi * fm * t2, 0.5)
plt.stem(t2, y2, linefmt = 'blue', markerfmt = 'bD')
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 1 & 2")
ax = plt.gca()
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# b

fs3 = 4*fm # Nyquist Theorem
Ts3 = 1/fs3
t3 = np.arange(0, 4*T, Ts3)
y3 = A * signal.sawtooth(2 * np.pi * fm * t3, 0.5)
plt.stem(t3,y3)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 3 (fs3 = 4fm)")
ax = plt.gca()
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

#c

A = 1 # V amplitude
#(i)
t = np.linspace(0, 4*T, 10000)
z = A*np.sin(2*np.pi*fm*t)

# a

# (i)

Ts1 = 1/fs1 # sampling with fs1
t1 = np.arange(0, 4*T, Ts1)
z1 = A*np.sin(2*np.pi*fm*t1)
plt.stem(t1,z1)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 1 (fs1 = 30fm)")
ax = plt.gca()
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# (ii)

Ts2 = 1/fs2 # sampling with fs2
t2 = np.arange(0, 4*T, Ts2)
z2 = A*np.sin(2*np.pi*fm*t2)
plt.stem(t2,z2)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 2 (fs2 = 50fm)")
ax = plt.gca()
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# (iii)

t1 = np.arange(0, 4*T, Ts1)
z1 = A*np.sin(2*np.pi*fm*t1)
plt.stem(t1,z1, linefmt = 'red', markerfmt = 'rD')

t2 = np.arange(0, 4*T, Ts2)
z2 = A*np.sin(2*np.pi*fm*t2)
plt.stem(t2,z2, linefmt = 'blue', markerfmt = 'bD')

plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 1 & 2")
ax = plt.gca()
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))

plt.show()

# b

fs3 = 4*fm # Nyquist Theorem
Ts3 = 1/fs3
t3 = np.arange(0, 4*T, Ts3)
y3 = A * signal.sawtooth(2 * np.pi * fm * t3, 0.5)
plt.stem(t3,y3)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 3 (fs = 4fm)")
ax = plt.gca()
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# (ii)

L = 1000 # Hz
t = np.linspace(0, 4*T, 10000)
q = A*np.sin(2*np.pi*fm*t) + A*np.sin(2*np.pi*(fm + L)*t)


#a

# (i)

Ts1 = 1/fs1 # sampling with fs1
t1 = np.arange(0, T, Ts1)
q1 = A*np.sin(2*np.pi*fm*t1) + A*np.sin(2*np.pi*(fm + L)*t1)
plt.stem(t1,q1)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 1 (fs1 = 30fm)")
ax = plt.gca()
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# (ii)

Ts2 = 1/fs2 # sampling with fs2
t2 = np.arange(0, T, Ts2)
q2 = A*np.sin(2*np.pi*fm*t2) + A*np.sin(2*np.pi*(fm + L)*t2)
plt.stem(t2,q2)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 2 (fs2 = 50fm)")
ax = plt.gca()
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# (iii)

t1 = np.arange(0, T, Ts1)
q1 = A*np.sin(2*np.pi*fm*t1) + A*np.sin(2*np.pi*(fm + L)*t1)
plt.stem(t1,q1, linefmt = 'red', markerfmt = 'rD')

t2 = np.arange(0, T, Ts2)
q2 = A*np.sin(2*np.pi*fm*t2) + A*np.sin(2*np.pi*(fm + L)*t2)
plt.stem(t2,q2, linefmt = 'blue', markerfmt = 'bD')

plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 1 & 2")
ax = plt.gca()
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# b

fs3 = 4*fm # Nyquist Theorem
Ts3 = 1/fs3
t3 = np.arange(0, T, Ts3)
q3 = A*np.sin(2*np.pi*fm*t3) + A*np.sin(2*np.pi*(fm + L)*t3)
plt.stem(t3,q3)
plt.xlabel("Time [s]")
plt.ylabel("Amplitude [V]")
plt.title("Sampled Signal 3 (fs = 4fm)")
ax = plt.gca()
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()


# EXERCISE 2

fm = 9000  # Hz
fs1 = 30*fm
T = 1/fm
A = 4 # V amplitude
Ts1 = 1/fs1  # sampling with fs1
t1 = np.arange(0, 4*T, Ts1)
y1 = A * signal.sawtooth(2 * np.pi * fm * t1, 0.5)

# a

bits = 5  # number of bits that will be used
levels = 2**bits
D = (2*A)/levels  # A is the highest magnitude

fig, ax = plt.subplots()

ax.yaxis.set_major_formatter(StrMethodFormatter("{x:07b}"))
ax.yaxis.set_ticks(np.arange(-100, 100, 1))

quant_signal = np.round(y1/D)*D

plt.stem(t1, quant_signal)
plt.xlabel("Time [sec]")
plt.ylabel("Levels [Gray Code]")
plt.title("Signal after quantization")
ax = plt.gca()  # fix x axis scale
xaxis = ax.xaxis
xaxis.major.formatter.set_powerlimits((0, 4))
plt.show()

# b

error = np.abs(y1 - quant_signal)  # quantization error

# (i)
error_first10 = error[0:10]

s10 = statistics.stdev(error_first10)
s10_2 = statistics.variance(error_first10)
# print(error_first10)
print("The standard deviation for the first 10 samples is: ", s10)

# (ii)

error_first20 = error[0:20]

s20 = statistics.stdev(error_first20)
s20_2 = statistics.variance(error_first20)
# print(error_first20)
print("The standard deviation for the first 20 samples is: ", s20)


# (iii)

error_quant = (1/3)*pow(A, 2)*pow(2, -2*bits) # standard deviation of quantization error
P_mean_30 = (1/30)*sum(map(lambda x: x*x, y1[0:30]))  # mean power of signal y1
SNR_10 = P_mean_30 / s10_2  # SNR for 10 samples
print('SNR for 10 samples : ', SNR_10)
SNR_20 = P_mean_30 / s20_2  # SNR for 20 samples
print('SNR for 20 samples : ', SNR_20)
SNR_theor = P_mean_30 / error_quant  # SNR for theoretical value
print('SNR for theoretical : ', SNR_theor)


# c

def gray_code(n_bits):
    gray_arr = list()
    gray_arr.append("0")
    gray_arr.append("1")
    i = 2
    j = 0
    while(True):
        if i>=1 << n_bits:
            break
        for j in range(i - 1, -1, -1):
            gray_arr.append(gray_arr[j])
        for j in range(i):
            gray_arr[j] = "0" + gray_arr[j]
        for j in range(i, 2 * i):
            gray_arr[j] = "1" + gray_arr[j]
        i = i << 1

    return gray_arr

gray_code_2 = gray_code(bits)

Bitstream = ''  # bit stream of output (string)
for i in range(0, 30):
    Bitstream += gray_code_2[int(quant_signal[i]+levels/2)]


samples_per_bit = 100
polar_rz = []
for i in range(0, len(Bitstream)):
    for j in range(0, samples_per_bit):
        polar_rz.append(int(Bitstream[i]))

t_bit_30 = np.linspace(0, 0.001*bits*30, samples_per_bit*bits*30, endpoint=False)
plt.plot(t_bit_30, fm/1000*signal.square(1*math.pi*t_bit_30, duty=polar_rz[0:samples_per_bit*bits*30]), label='POLAR RZ')
plt.title('Bit stream of quantized signal (fs1=30fm)')
plt.xlabel('Time (sec)')
plt.ylabel('Amplitude (V)')
plt.grid()
plt.xlim(0, 0.12)
plt.show()


# EXERCISE 3

Abit = 9  # Volts Amplitude
Tb = 0.25 # sec bit duration
fm = 9000 #Hz
randbits = 36 # random bits

rand_bits = np.random.randint(2, size=(randbits))  # requested bit ganerator
# print(rand_bits)

# b

rand_bits_linspace = []
samples = 100 # samples per bit

for i in range(0, len(rand_bits)):
    for j in range(0, samples):
        rand_bits_linspace.append(rand_bits[i])

t_randbits = np.linspace(0, Tb * randbits, randbits * samples)
y_randbits = Abit * signal.square(2 * math.pi * t_randbits, duty=rand_bits_linspace[0:randbits * samples])
plt.plot(t_randbits, y_randbits) #Β-PAM modulation of bit sequence
plt.grid()
plt.title('B-PAM modulation')
plt.xlabel('Time (sec)')
plt.ylabel('Amplitude (V)')
plt.show()

# c

Eb = pow(Abit, 2) * Tb
xbpam = [-math.sqrt(Eb), math.sqrt(Eb)]
ybpam = [0, 0]
plt.scatter(xbpam, ybpam) #Constellation diagram of B-PAM signal (without AWGN)
plt.ylim([-0.5, 0.5])
plt.grid()
plt.title('Constellation of B-PAM signal')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.show()

# d

def SNR_linear(snr_ratio):
   return 10**(snr_ratio / 10) #SNR linear scale function

L5 = Eb / SNR_linear(5)  #dB to linear scale

# Eb/N0 = 5 dB
awgn5 = np.random.normal(0, np.sqrt(L5), 2 * randbits * samples).view(np.complex128) #complex awgn (5dB)
plt.subplot(3, 1, 2)
plt.plot(t_randbits, y_randbits + awgn5.real, label='Eb/N0 = 5 dB')
plt.grid()
plt.title('Signal with Eb/N0 = 5 dB')
plt.ylabel('Amplitude (V)')
plt.legend(loc='upper right')

L15 = Eb / SNR_linear(15) #dB to linear scale

# Eb/N0 = 15 dB
awgn15 = np.random.normal(0, np.sqrt(L15), 2 * randbits * samples).view(np.complex128) #complex awgn (15dB)
plt.subplot(3, 1, 3)
plt.plot(t_randbits, y_randbits + awgn15.real, label='Eb/N0 = 15 dB')
plt.grid()
plt.title('Signal with Eb/N0 = 15 dB')
plt.xlabel('Time (sec)')
plt.ylabel('Amplitude (V)')
plt.legend(loc='upper right')

# B-PAM signal from previous
plt.subplot(3, 1, 1)
plt.plot(t_randbits, y_randbits, label='B-PAM')
plt.grid()
plt.title('B-PAM modulation of generated bits')
plt.ylabel('Amplitude (V)')
plt.legend(loc='upper right')
plt.subplots_adjust(hspace=0.75) # space between subplots
plt.show()

# e

#Constellation diagram for Eb/N0 = 5 dB
x_bpam_with_awgn5 = (y_randbits[::1] + awgn5.real[::1]) * math.sqrt(Tb)
y_bpam_with_awgn5 = (awgn5.imag[::1]) * math.sqrt(Tb)

plt.subplot(3, 1, 1)
plt.scatter(x_bpam_with_awgn5, y_bpam_with_awgn5, s=1, label='Eb/N0 = 5 dB')
plt.ylim([-1, 1])
plt.grid()
plt.title('Constellation of B-PAM')
plt.legend(loc='upper left')
plt.ylabel('Quadrature')

#Constellation diagram for Eb/N0 = 15 dB
x_bpam_with_awgn15 = (y_randbits[::1] + awgn15.real[::1]) * math.sqrt(Tb)
y_bpam_with_awgn15 = (awgn15.imag[::1]) * math.sqrt(Tb)

plt.subplot(2, 1, 2)
plt.scatter(x_bpam_with_awgn15, y_bpam_with_awgn15, s=1, label='Eb/N0 = 15 dB')
plt.ylim([-0.4, 0.4])
plt.grid()
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.legend(loc='upper left')
plt.show()

# z

randbits2 = 10 ** 6
rand_bits_2 = np.random.randint(2, size=(randbits2)) #random bits generated

rand_bits2_mod = rand_bits_2 * 2 * Abit - Abit
tBER = np.arange(0, 16)

# Experimental Plot
No_experimental = []; awgn_experimental = []; BER_experimental = []
for i in tBER:
    No_experimental.append(Eb / SNR_linear(i))
    awgn_experimental.append(np.random.normal(0, np.sqrt(No_experimental[i]), 2 * randbits2).view(np.complex128)) # awgn noise
    output_sign2 = rand_bits2_mod + awgn_experimental[i].real # noise added to initial signal
    received_sign2 = (output_sign2 >= 0).astype(int) #de-noise
    BER_experimental.append(np.sum(received_sign2 != rand_bits_2) / randbits2) # BER calculation

# Theoretical Plot
def q_bpam(a):
    return (1.0/math.sqrt(2*math.pi))*scipy.integrate.quad(lambda x: math.exp(-(x**2)/2), a, pow(10,2))[0]

BER_theoretical = []
for i in tBER:
    BER_theoretical.append(q_bpam(np.sqrt(2 * SNR_linear(i))))

plt.semilogy(tBER, BER_experimental, color='g', marker='D', markersize=2, linestyle='', label='Experimental BER') # log scale in y axis
plt.semilogy(tBER, BER_theoretical, color='r',marker='', linestyle='dotted', label='Theoretical BER') # log scale in y axis
plt.title('Experimental & Theoretical BER')
plt.xlabel('Eb/N0 (dB)')
plt.ylabel('BER')
plt.grid()
plt.legend(loc='upper right')
plt.show()


# EXERCISE 4

# a

# Constellation

qpsk_num_symbols = 100
qpsk_constellation_size = math.sqrt(Eb)  # size of qpsk constellation
qpsk_points = np.random.randint(0, 4, qpsk_num_symbols)  # 4 points generated
qpsk_degrees = qpsk_points * 360 / 4.0 + 45  # degrees (K*π/4) K = 0,1,...
qpsk_position = qpsk_degrees * np.pi / 180.0  # position for each point
qpsk_symbols = qpsk_constellation_size * np.cos(qpsk_position) + qpsk_constellation_size * 1j * np.sin(
    qpsk_position)  # complex number
plt.plot(np.real(qpsk_symbols), np.imag(qpsk_symbols), '.')
plt.grid()
plt.xlim(-qpsk_constellation_size - 1, qpsk_constellation_size + 1)
plt.ylim(-qpsk_constellation_size - 1, qpsk_constellation_size + 1)
plt.title('Constellation of QPSK [($π$/4) GRAY]')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.show()

# b

# Constellation

# NOISE (5dB)
awgn5 = np.random.normal(0, np.sqrt(L5), 2 * qpsk_num_symbols).view(np.complex128)  # complex AWGN (5dB)
qpsk5_points = qpsk_symbols + awgn5 * math.sqrt(Tb)
plt.plot(np.real(qpsk5_points), np.imag(qpsk5_points), '.')
plt.grid()
plt.title('Constellation with noise Eb/N0 = 5 dB')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.show()

# NOISE (15dB)
awgn15 = np.random.normal(0, np.sqrt(L15), 2 * qpsk_num_symbols).view(np.complex128)  # complex AWGN (15dB)
qpsk15_points = qpsk_symbols + awgn15 * math.sqrt(Tb)
plt.plot(np.real(qpsk15_points), np.imag(qpsk15_points), '.')
plt.grid()
plt.title('Constellation with noise Eb/N0 = 15 dB')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.show()

# c

randbits_4 = 10 ** 5  # number of bits genarated
rand_bits4 = np.random.randint(2, size=(randbits_4))  # random bits generated (array)
rand_bits4_string = ''.join([str(i) for i in rand_bits4])  # resulting string in random array of bits

# Experimental Plot
rand_bits_qpsk4 = []
for i in range(0, len(rand_bits4_string), 2):
    x = rand_bits4_string[i] + rand_bits4_string[i + 1]
    if (x == '00'):
        rand_bits_qpsk4.append(0)
    elif (x == '01'):
        rand_bits_qpsk4.append(1)
    elif (x == '11'):
        rand_bits_qpsk4.append(2)
    elif (x == '10'):
        rand_bits_qpsk4.append(3)

qpsk_experimental_degrees = np.array(rand_bits_qpsk4) * 360 / 4.0 + 45  # degrees (K*π/4) K = 0,1,2,...
qpsk_experimental_position = qpsk_experimental_degrees * np.pi / 180.0  # position for each point
qpsk_experimental_symbols = qpsk_constellation_size * np.cos(
    qpsk_experimental_position) + qpsk_constellation_size * 1j * np.sin(qpsk_experimental_position)  # complex number

awgn_experimental4 = [];
output_sign4 = [];
output_sign_4position = [];
BER_experimental4 = []

for i in tBER:
    # Generate Noise
    awgn_experimental4.append(np.random.normal(0, np.sqrt(No_experimental[i] / 2), 2 * randbits_4 // 2).view(
        np.complex128))  # list of awgn noise for each SNR ratio (2* because of complex numbers , /2 because of qpsk modulation)
    output_sign4.append(qpsk_experimental_symbols + awgn_experimental4[i])

    # Reconstruct signal
    output_sign_4position.append(np.arctan2(np.imag(output_sign4[i]), np.real(output_sign4[i])))
    received_sign4 = ''  # reconstructed binary signal to string
    for j in output_sign_4position[i]:
        if (j >= 0 and j < np.pi / 2):
            received_sign4 += '00'
        elif (j >= np.pi / 2 and j < np.pi):
            received_sign4 += '01'
        elif (j >= -np.pi and j < -np.pi / 2):
            received_sign4 += '11'
        elif (j >= -np.pi / 2 and j < 0):
            received_sign4 += '10'

    # BER Calculation
    error_bits = 0
    for j in range(0, len(received_sign4) - 1):
        if (received_sign4[j] != rand_bits4_string[j]):
            error_bits += 1
    BER_experimental4.append(error_bits / len(received_sign4))

# Theoretical Plot
BER_theor_4 = []
for i in tBER:
    BER_theor_4.append(q_bpam(np.sqrt(SNR_linear(i))))

plt.semilogy(tBER, BER_experimental4, color='r', marker='D', markersize=2, linestyle='', label='Experimental QPSK')
plt.semilogy(tBER, BER_theor_4, marker='', linestyle='dotted', linewidth=1, label='Theoretical QPSK')
plt.semilogy(tBER, BER_experimental, color='g', marker='D', markersize=2, linestyle='', label='Experimental BPSK')
plt.title('Experimental & Theoretical BER')
plt.xlabel('Eb/N0 (dB)')
plt.ylabel('BER')
plt.legend(loc='upper right')
plt.grid()
plt.show()

# d

file_name = 'rice_odd.txt'  # 9 = odd number


# (i)
# ASCII to Binary
def text_bits(text, encoding='utf-8', errors='surrogatepass'):
    bits = bin(int(binascii.hexlify(text.encode(encoding, errors)), 16))[2:]
    return bits.zfill(8 * ((len(bits) + 7) // 8))


file = open(file_name, 'r')

file_string = ''
for i in file:
    file_string += i

file_ascii = []
for i in file_string:
    file_ascii.append(ord(i))

# Text converted to binary
file_binary = text_bits(file_string)

# (ii)
t_ascii = np.arange(0, len(file_ascii))
plt.plot(t_ascii, file_ascii, color='k', linestyle='-', linewidth=0.75, label='Signal (txt)')
plt.title("8-bit Quantization")
plt.xlabel('Characters')
plt.ylabel('ASCII')
plt.legend(loc='upper right')
plt.xlim(0, 500)
plt.ylim(31, 120)
plt.show()

# (iii)
file_bin_qpsk = []
for i in range(0, len(file_binary), 2):
    x = file_binary[i] + file_binary[i + 1]
    if (x == '00'):
        file_bin_qpsk.append(0)
    elif (x == '01'):
        file_bin_qpsk.append(1)
    elif (x == '11'):
        file_bin_qpsk.append(2)
    elif (x == '10'):
        file_bin_qpsk.append(3)

qpsk_text_degrees = np.array(file_bin_qpsk) * 360 / 4.0  # degrees (K*pi/2) K = 0,1,2,...
qpsk_text_position = qpsk_text_degrees * np.pi / 180.0  # position for each point
qpsk_text_symbols = 1 * np.cos(qpsk_text_position) + 1 * 1j * np.sin(qpsk_text_position)  # complex number

plt.plot(np.real(qpsk_text_symbols), np.imag(qpsk_text_symbols), '.')
plt.grid()
plt.xlim(-qpsk_constellation_size - 1, qpsk_constellation_size + 1)
plt.ylim(-qpsk_constellation_size - 1, qpsk_constellation_size + 1)
plt.title('Constellation of QPSK (text)')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.show()

# (iv)
Eb_text = pow(1, 2) * Tb
L5_text = Eb_text / SNR_linear(5)
L15_text = Eb_text / SNR_linear(15)

# AWGN NOISE Es/N0 = 5dB
text_awgn5 = np.random.normal(0, np.sqrt(L5_text), 2 * len(file_bin_qpsk)).view(np.complex128)  # AWGN (5dB)
qpsk5_points = qpsk_text_symbols + text_awgn5  # signal + noise(5dB)

# AWGN NOISE Es/N0 = 15dB
text_awgn15 = np.random.normal(0, np.sqrt(L15_text), 2 * len(file_bin_qpsk)).view(np.complex128)  # AWGN (15dB)
qpsk15_points = qpsk_text_symbols + text_awgn15  # signal + noise(15dB)

# (v)
# Signal Reconstruction

# Es/N0 = 5dB
qpsk_reconstruction_position5 = np.arctan2(np.imag(qpsk5_points), np.real(qpsk5_points))
file_bin_reconstruct_5 = ''
for i in qpsk_reconstruction_position5:
    if (i >= -np.pi / 4 and i < np.pi / 4):
        file_bin_reconstruct_5 += '00'
    elif (i >= np.pi / 4 and i < np.pi * 3 / 4):
        file_bin_reconstruct_5 += '01'
    elif (i >= np.pi * 3 / 4 or i < -np.pi * 3 / 4):
        file_bin_reconstruct_5 += '11'
    elif (i >= -np.pi * 3 / 4 and i < -np.pi / 4):
        file_bin_reconstruct_5 += '10'

# Es/N0 = 15dB
qpsk_reconstruction_position15 = np.arctan2(np.imag(qpsk15_points), np.real(qpsk15_points))
file_bin_reconstruct_15 = ''
for i in qpsk_reconstruction_position15:
    if (i >= -np.pi / 4 and i < np.pi / 4):
        file_bin_reconstruct_15 += '00'
    elif (i >= np.pi / 4 and i < np.pi * 3 / 4):
        file_bin_reconstruct_15 += '01'
    elif (i >= np.pi * 3 / 4 or i < -np.pi * 3 / 4):
        file_bin_reconstruct_15 += '11'
    elif (i >= -np.pi * 3 / 4 and i < -np.pi / 4):
        file_bin_reconstruct_15 += '10'

# Constellation Plot

# Es/N0 = 5dB
plt.plot(np.real(qpsk5_points), np.imag(qpsk5_points), '.')
plt.grid()
plt.title('QPSK Constellation for Es/N0 = 5 dB')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.show()

# Es/N0 = 15dB
plt.plot(np.real(qpsk15_points), np.imag(qpsk15_points), '.')
plt.grid()
plt.title('QPSK Constellation for Es/N0 = 15 dB')
plt.xlabel('In Phase')
plt.ylabel('Quadrature')
plt.show()

# (vi)

# Experimental BER Calculator with Es/N0 = 5 & 15 dB
counter_BER5 = 0.0
counter_BER15 = 0.0
for i in range(0, len(file_binary) - 1):
    if (file_binary[i] != file_bin_reconstruct_5[i]):
        counter_BER5 += 1
    if (file_binary[i] != file_bin_reconstruct_15[i]):
        counter_BER15 += 1

BER_experimental5 = counter_BER5 / len(file_binary)
BER_experimental15 = counter_BER15 / len(file_binary)

# Theoretical BER Calculator with Es/N0 = 5 & 15 dB
BER_theorerical5 = q_bpam(np.sqrt(SNR_linear(5)))
BER_theoretical15 = q_bpam(np.sqrt(SNR_linear(15)))

print('Experimental BER (Noise 5 dB) :', str(BER_experimental5))
print('Theoretical BER (Noise 5 dB) :', str(BER_theorerical5))
print('Experimental BER (Noise 15 dB) :', str(BER_experimental15))
print('Theoretical BER (Noise 15 dB) :', str(BER_theoretical15))

# (vii)

text_export_name_5dB = 'rice_odd_export5dB'
text_export_name_15dB = 'rice_odd_export15dB'

# File Reconstruction
# Es/N0 = 5 dB
file_binary_reconstruction5 = [file_bin_reconstruct_5[i:i + 8] for i in range(0, len(file_bin_reconstruct_5), 8)]
file_string_reconstruction5 = ''
for i in file_binary_reconstruction5:
    file_string_reconstruction5 += chr(int(i, 2))
new_file = open(text_export_name_5dB + '.txt', 'w', encoding='utf-8')
new_file.write(file_string_reconstruction5)
new_file.close()

# Es/N0 = 15 dB
file_binary_reconstruction15 = [file_bin_reconstruct_15[i:i + 8] for i in range(0, len(file_bin_reconstruct_15), 8)]
file_string_reconstruction15 = ''
for i in file_binary_reconstruction15:
    file_string_reconstruction15 += chr(int(i, 2))
new_file = open(text_export_name_15dB + '.txt', 'w', encoding='utf-8')
new_file.write(file_string_reconstruction15)
new_file.close()


# EXERCISE 5

fm = 9000
Ampl = fm/1000 #(V) Amplitude of bit stream
T_b = 0.25 #(sec) bit duration
E_b = pow(Ampl, 2)*T_b
qpsk_v_size = math.sqrt(E_b)  # vector size of qpsk constellation


# a

audio_signal = 'soundfile1_lab2.wav'
audio_samplerate, audio_file = wavfile.read(audio_signal)

plt.plot(audio_file)
plt.title('Audio file')
plt.xlabel("Time (s)")
plt.ylabel("Amplitude")
plt.show()

# b

quant_bits = 8
quant_levels = 2**quant_bits
max_audio = max(abs(audio_file))
audio_delta = (2*max_audio)/(quant_levels-1)

quant_audio_file = np.copy(audio_file)
#new_audio_file = np.copy(audio_file)
for i in range(0, audio_file.size):
    quant_audio_file[i] = int(math.floor(round(audio_file[i],4)/audio_delta)) #quantized levels (int)
    #new_audio_file[i] = audio_delta*(quant_audio_file[i])+audio_delta/2 #mid-riser quantization


gray_code_ex5 = gray_code(quant_bits)
plt.plot(quant_audio_file)
plt.title('Quantized signal with mid riser (8 bits)')
plt.xlabel('Time (s)')
plt.ylabel("Quantized value")
plt.show()


# c

# Convert audio file to binary string

audio_bin = ''
for i in range(0, audio_file.size):
    audio_bin += gray_code_ex5[int(quant_audio_file[i] + quant_levels/2)]

audio_bin_qpsk = []
for i in range(0, len(audio_bin), 2):
    x = audio_bin[i]+audio_bin[i+1]
    if (x=='00'):
        audio_bin_qpsk.append(0)
    elif (x=='01'):
        audio_bin_qpsk.append(1)
    elif (x=='11'):
        audio_bin_qpsk.append(2)
    elif (x=='10'):
        audio_bin_qpsk.append(3)

qpsk_degrees = np.array(audio_bin_qpsk)*360/4.0  # i = i + 90 deg
qpsk_radians = qpsk_degrees*np.pi/180.0  # convert deg to rad
qpsk = np.cos(qpsk_radians) + 1j*np.sin(qpsk_radians)  # create te complex number
plt.plot(np.real(qpsk), np.imag(qpsk), '.')
plt.xlim(-qpsk_v_size, qpsk_v_size)
plt.ylim(-qpsk_v_size, qpsk_v_size)
plt.title('Quantized signal with QPSK modulation ')
plt.xlabel('In-Phase')
plt.ylabel('Quadrature')
plt.show()


# d

# SNR to linear scale function

def SNR_dB_lin(snr_ratio):
    return 10**(snr_ratio / 10)

E_b_audio = pow(1, 2)*T_b
No_4 = E_b_audio / SNR_dB_lin(4)
No_14 = E_b_audio / SNR_dB_lin(14)

# For 4dB
awgn_4 = np.random.normal(0, np.sqrt(No_4), 2*len(audio_bin_qpsk)).view(np.complex128) #complex awgn (5dB)
qpsk_4 = qpsk + awgn_4
#print(qpsk_4)

# For 14dB
awgn_14 = np.random.normal(0, np.sqrt(No_14), 2*len(audio_bin_qpsk)).view(np.complex128) #complex awgn (15dB)
qpsk_14 = qpsk + awgn_14
#print(qpsk_14)


# e

# For 4dB
plt.plot(np.real(qpsk_4), np.imag(qpsk_4), '.')
plt.title('Es/No=4 : constellation')
plt.xlabel('In-Phase')
plt.ylabel('Quadrature')
plt.show()

# For 14dB
plt.plot(np.real(qpsk_14), np.imag(qpsk_14), '.')
plt.title('Es/No=14 : constellation')
plt.xlabel('In-Phase')
plt.ylabel('Quadrature')
plt.show()


# st

# We reconstruct the signals in order to calculate the possibility of BER

# For SNR=4dB

rec_4 = np.arctan2(np.imag(qpsk_4), np.real(qpsk_4))
bin_rec_4 = ''
for i in rec_4:
    if i>=-np.pi/4 and i<np.pi/4:
        bin_rec_4 += '00'
    elif i>=np.pi/4 and i<np.pi*3/4:
        bin_rec_4 += '01'
    elif i>=np.pi*3/4 or i<-np.pi*3/4:
        bin_rec_4 += '11'
    elif i>=-np.pi*3/4 and i<-np.pi/4:
        bin_rec_4 += '10'


# For SNR=14dB

rec_14 = np.arctan2(np.imag(qpsk_14), np.real(qpsk_4))
bin_rec_14 = ''
for i in rec_14:
    if i>=-np.pi/4 and i<np.pi/4:
        bin_rec_14 += '00'
    elif i>=np.pi/4 and i<np.pi*3/4:
        bin_rec_14 += '01'
    elif i>=np.pi*3/4 or i<-np.pi*3/4:
        bin_rec_14 += '11'
    elif i>=-np.pi*3/4 and i<-np.pi/4:
        bin_rec_14 += '10'


# BER from experiment
count4 = 0.0
count14 = 0.0
for i in range(0, len(audio_bin)-1):
    if audio_bin[i] != bin_rec_4[i]:
        count4 += 1
    if audio_bin[i] != bin_rec_14[i]:
        count14 += 1

ex_BER4 = count4 / len(audio_bin)
print('The experimental BER for SNR=4dB is equal to : ', ex_BER4)

ex_BER14 = count14 / len(audio_bin)
print('The experimental BER for SNR=14dB is equal to : ', ex_BER14)

# Theoritical BER

def q_bpam(a):
    return (1.0/math.sqrt(2*math.pi))*scipy.integrate.quad(lambda x: math.exp(-(x**2)/2), a, pow(10, 2))[0]

th_BER4 = q_bpam(np.sqrt(SNR_dB_lin(4)))
print('The theoretical BER for SNR=4dB is equal to : ', th_BER4 )

th_BER14 = q_bpam(np.sqrt(SNR_dB_lin(14)))
print('The theoretical BER for SNR=14dB is equal to : ', th_BER14)


# z

audio_exp4dB = 'soundfile1_export_4dB'
audio_exp14dB = 'soundfile1_export_14dB'

# We reconstruct the signals

# For SNR = 4dB

audio_binary_rec_array4 = [bin_rec_4[i:i+8] for i in range(0, len(bin_rec_4), 8)]  # create list elements with 8 bits
audio_new_rec4 = []  # reconstructed signal
audio_quant_rec4 = []  # new levels

for i in range (0, len(audio_binary_rec_array4)):
    audio_quant_rec4.append(gray_code_ex5.index(audio_binary_rec_array4[i]) - quant_levels/2)
    audio_new_rec4.append(audio_delta*(audio_quant_rec4[i]) + audio_delta/2)

wavfile.write(audio_exp4dB+'.wav', audio_samplerate, np.array(audio_new_rec4, dtype=np.uint8))


# For SNR = 14dB

audio_binary_rec_array14 = [bin_rec_14[i:i+8] for i in range(0, len(bin_rec_14), 8)]  # create list elements with 8 bits
audio_new_rec14 = []  # reconstructed signal
audio_quant_rec14 = []  # new levels

for i in range (0, len(audio_binary_rec_array14)):
    audio_quant_rec14.append(gray_code_ex5.index(audio_binary_rec_array14[i]) - quant_levels/2)
    audio_new_rec14.append(audio_delta*(audio_quant_rec14[i]) + audio_delta/2)

wavfile.write(audio_exp14dB+'.wav', audio_samplerate, np.array(audio_new_rec14, dtype=np.uint8))