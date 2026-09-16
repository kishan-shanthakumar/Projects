import numpy as np
import tensorflow as tf
from tensorflow import keras
import os

json_file=open('model.json','r')
model=json_file.read()
json_file.close()
model.load_weights('model.h5')
print('Model loaded')

