from django.urls import path, re_path
from . import views
from .views import FileUploadView

urlpatterns = [
    re_path(r'^upload/', FileUploadView.as_view()),
    path('', FileUploadView.as_view())
]

