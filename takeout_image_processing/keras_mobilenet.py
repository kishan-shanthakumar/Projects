import keras
from keras.applications.resnet50 import preprocess_input, decode_predictions
import numpy as np

model = keras.applications.MobileNetV3Large(
    weights="imagenet"
)

img_path = '/mnt/nas/Takeout/Temp/Gokarna/20250322_133508.jpg'
img = keras.utils.load_img(img_path, target_size = (224, 224))
x = keras.utils.img_to_array(img)
x = np.expand_dims(x, axis=0)
x = preprocess_input(x)

preds = model.predict(x)
print('Predicted:', decode_predictions(preds, top=10)[0])