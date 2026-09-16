import tensorflow as tf
from tensorflow import keras
import numpy as np
import pandas as pd
import os

sd=pd.read_excel('Song_Dataset.xlsx')
sd.drop(['Name','Artist'],axis=1,inplace=True)
sdr=pd.Series(sd['Rating (10)'])
sd.drop(['Rating (10)'],axis=1,inplace=True)
sd=np.array(sd)
sdr=np.array(sdr)

model=keras.Sequential()
model.add(keras.layers.Dense(128, input_dim=11, activation='relu'))
model.add(keras.layers.Dense(128, activation='relu'))
model.add(keras.layers.Dense(128, activation='relu'))
model.add(keras.layers.Dense(128, activation='relu'))
model.add(keras.layers.Dense(128, activation='relu'))
model.add(keras.layers.Dense(128, activation='relu'))
model.add(keras.layers.Dense(128, activation='relu'))
model.add(keras.layers.Dense(128, activation='relu'))
model.add(keras.layers.Dense(128, activation='relu'))
model.add(keras.layers.Dense(128, activation='relu'))
model.add(keras.layers.Dense(1))

model.compile(optimizer='adadelta',loss='mean_squared_error')

fin = model.fit(sd,sdr,epochs=100000)

print(fin)

model_json=model.to_json()
with open("model.json",'w') as json_file:
	json_file.write(model_json)
model.save_weights('model.h5')
print('Saved model to disk')
