from django.shortcuts import render

# Create your views here.

from django.http import HttpResponse
from os import listdir
from os.path import isfile, join

def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")
