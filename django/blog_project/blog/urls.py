# blog/urls.py

from django.urls import path
from . import views

urlpatterns = [
    path('login/', views.login_api, name='login_api'),
    path('posts/', views.post_list_api, name='post_list_api'),
    path('posts/<int:pk>/', views.post_detail_api, name='post_detail_api'),
    path('posts/create/', views.create_post_api, name='create_post_api'),
]
