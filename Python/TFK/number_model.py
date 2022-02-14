import tensorflow as tf
from tensorflow import keras
import numpy as np
xs=np.array([-5.0,-4.0,-3.0,-2.0,-1.0,0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0],dtype=float)
ys=np.array([-11.0,-9.0,-7.0,-5.0,-3.0,-1.0,1.0,3.0,5.0,7.0,9.0,11.0,13.0,15.0,17.0],dtype=float)
model=keras.Sequential([tf.keras.layers.Flatten(),
tf.keras.layers.Dense(2048, activation=tf.nn.relu),
tf.keras.layers.Dense(2048, activation=tf.nn.relu),
tf.keras.layers.Dense(2048, activation=tf.nn.relu),
tf.keras.layers.Dense(2048, activation=tf.nn.relu),
tf.keras.layers.Dense(2048, activation=tf.nn.relu),
tf.keras.layers.Dense(2048, activation=tf.nn.relu),
tf.keras.layers.Dense(2048, activation=tf.nn.relu),
tf.keras.layers.Dense(2048, activation=tf.nn.relu),
keras.layers.Dense(units=1, input_shape=[1])])
model.compile(optimizer='adam',loss='mean_absolute_error')
model.fit(xs,ys,epochs=5000)
print(model.predict([10.0]))
