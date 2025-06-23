# blog/views.py

from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from django.contrib.auth import authenticate
from .models import Post
from .serializers import PostSerializer, PostListSerializer
from rest_framework.permissions import IsAuthenticatedOrReadOnly


# Login API
@api_view(['POST'])
@permission_classes([AllowAny])
def login_api(request):
    username = request.data.get('username')
    password = request.data.get('password')
    user = authenticate(username=username, password=password)
    if user:
        token, _ = Token.objects.get_or_create(user=user)
        return Response({'token': token.key, 'user_id': user.id})
    else:
        return Response({'error': 'Invalid Credentials'}, status=400)

# Post List API
@api_view(['GET', 'POST'])
@permission_classes([IsAuthenticatedOrReadOnly])
def post_list_api(request):
    if request.method == 'GET':
        posts = Post.objects.all().order_by('-created_at')
        serializer = PostSerializer(posts, many=True)
        return Response(serializer.data)

    elif request.method == 'POST':
        serializer = PostSerializer(data=request.data, context={'request': request})
        if serializer.is_valid():
            serializer.save(author=request.user)
            return Response(serializer.data, status=201)  # FIXED here — status=201
        else:
            return Response(serializer.errors, status=400)


# Post Detail API
@api_view(['GET'])
@permission_classes([AllowAny])
def post_detail_api(request, pk):
    try:
        post = Post.objects.get(pk=pk)
    except Post.DoesNotExist:
        return Response({'error': 'Post not found'}, status=404)
    
    serializer = PostSerializer(post)
    return Response(serializer.data)

# Create Post API
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def create_post_api(request):
    title = request.data.get('title')
    content = request.data.get('content')

    if title and content:
        post = Post.objects.create(
            title=title,
            content=content,
            author=request.user
        )
        serializer = PostSerializer(post)
        return Response(serializer.data)
    else:
        return Response({'error': 'Title and content required'}, status=400)
