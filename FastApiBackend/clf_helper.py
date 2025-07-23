import tensorflow as tf
import numpy as np
from PIL import Image

model_path = "../FastApiBackend/plantDisClfs.h5"
class_names = ['Apple Applescab',
               'Apple Black rot',
               'Apple Cedar Apple rust',
               'Apple Healthy',
               'Blueberry Healthy',
               'Cherry Powdery Mildew',
               'Cherry Healthy',
               'Corn(maize) Cercospora Leaf Spot Gray Leaf Spot',
               'Corn(maize) Common Rust',
               'Corn(maize) Northern Leaf Blight',
               'Corn(maize) Healthy',
               'Grape Black Rot',
               'Grape Esca (Black Measles)',
               'Grape Leaf Blight(Isariopsis Leaf Spot)',
               'Grape Healthy',
               'Orange Haunglongbing(Citrus Greening)',
               'Peach Bacterial Spot',
               'Peach Healthy',
               'Pepper Bell Bacterial Spot',
               'Pepper Bell Healthy',
               'Potato Early Blight',
               'Potato Late Blight',
               'Potato Healthy',
               'Raspberry Healthy',
               'Soybean Healthy',
               'Squash Powdery Mildew',
               'Strawberry Leaf Scorch',
               'Strawberry Healthy',
               'Tomato Bacterial Spot',
               'Tomato Early Blight',
               'Tomato Late Blight',
               'Tomato Leaf Mold',
               'Tomato Septoria Leaf Spot',
               'Tomato Spider Mites Two Spotted Spidermite',
               'Tomato Target Spot',
               'Tomato Yellow Leaf Curl Virus',
               'Tomato Mosaic Virus',
               'Tomato Healthy']


class PlantDiseaseClassifier:

    def __init__(self):
        self.model = tf.keras.models.load_model(model_path)

    def predict_img(self, image):
        # Load the image
        image = image.resize((256, 256))
        image_array = np.array(image)

        # Preprocess the image
        img_array = tf.keras.preprocessing.image.img_to_array(image_array)
        img_array = tf.expand_dims(img_array, 0)

        # Make predictions
        predictions = self.model.predict(img_array)
        predicted_class = class_names[np.argmax(predictions[0])]
        confidence = round(100 * np.max(predictions[0]), 2)

        return predicted_class, confidence

    def predict_img_path(self, image_path):
        # Load the image
        single_image = Image.open(image_path)
        single_image = single_image.resize((256, 256))
        single_image_array = np.array(single_image)

        # Preprocess the image
        img_array = tf.keras.preprocessing.image.img_to_array(single_image_array)
        img_array = tf.expand_dims(img_array, 0)

        # Make predictions
        predictions = self.model.predict(img_array)
        predicted_class = class_names[np.argmax(predictions[0])]
        confidence = round(100 * np.max(predictions[0]), 2)

        return predicted_class, confidence


if __name__ == "__main__":
    # Your class names list

    image_path = "D:\Project\ResumeProject\PlantDiseaseClassificationApp\PlantDiseaseClfLearning\TomatoYellowCurlVirus1.jpg"

    classifier = PlantDiseaseClassifier()
    predicted_class, confidence = classifier.predict(image_path)

    print("Predicted Class:", predicted_class)
    print("Confidence:", confidence)
