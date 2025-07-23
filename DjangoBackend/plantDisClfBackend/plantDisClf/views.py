from PIL import Image
from rest_framework import status, views
from rest_framework.parsers import MultiPartParser
from rest_framework.response import Response

from .clf_helper import PlantDiseaseClassifier


class FileUploadView(views.APIView):
    parser_classes = [MultiPartParser]

    def post(self, request):
        file_obj = request.data['file']
        uploaded_image = Image.open(file_obj)

        classifier = PlantDiseaseClassifier()
        predicted_class, confidence = classifier.predict_img(uploaded_image)

        return Response({'predicted_class': predicted_class, 'confidence': confidence}, status=status.HTTP_200_OK)




