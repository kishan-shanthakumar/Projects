import tensorflow as tf
from tensorflow import keras
import numpy as np
import matplotlib.pyplot as plt
from scipy import optimize
a=np.array([7,49,163,385,751,1297,2059,3073,4375,6001,7987,10369,13183,16465,20251,24577])
t=np.array([0.011,0.046,0.48,2.66,10.762,36.020,104.929,275.499,650.817,1425.556,2887.671,5497.345,9949.648,17321.781,29067.254,47135.484])
model=keras.Sequential([tf.keras.layers.Flatten(),
tf.keras.layers.Dense(32, activation=tf.nn.relu),
keras.layers.Dense(units=1, input_shape=[1])])
model.compile(optimizer='adam',loss='mean_absolute_error')
model.fit(np.log(10000*a),np.log(t),epochs=5000)
print(model.predict([43.749]))
plt.plot(np.log(10000*a),np.log(t))
plt.show()
'''curve_fit=np.polyfit(a,np.log(t),1)
print(curve_fit)
fin=np.exp(curve_fit[1])*np.exp(a*curve_fit[0])
plt.plot(a,fin)
plt.plot(a,t)
plt.show()'''
