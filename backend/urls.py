"""
URL configuration for backend project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include, re_path
from django.views.generic import TemplateView
from django.views.decorators.csrf import csrf_exempt
from graphene_django.views import GraphQLView
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    # Admin
    path('admin/', admin.site.urls),
    
    # GraphQL endpoint
    path('graphql/', csrf_exempt(GraphQLView.as_view(graphiql=True))),
    
    # API documentation
    path('api-docs/', TemplateView.as_view(
        template_name='api_docs.html',
        extra_context={'graphql_endpoint': '/graphql/'}
    ), name='api_docs'),
]

# Serve the Flutter `index.html` as the SPA entry point. The template loader
# looks in the Flutter build output directory because we've added it to
# `TEMPLATES['DIRS']` in settings.py. The `re_path` catch-all ensures client
# side routing works.
urlpatterns += [
    path('', TemplateView.as_view(template_name='index.html'), name='home'),
    # Catch-all for the SPA, but exclude API/static/admin paths so those
    # routes are handled by their own views and not the SPA template.
    re_path(r'^(?!(?:api|graphql|admin|static|media|__debug__)).*$', TemplateView.as_view(template_name='index.html')),
]

# Serve static and media files in development
if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    
    # Debug toolbar
    import debug_toolbar
    urlpatterns = [
        path('__debug__/', include(debug_toolbar.urls)),
    ] + urlpatterns