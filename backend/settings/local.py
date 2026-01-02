from .base import *

DEBUG = True

# Database for development
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}

# Allow all origins in development
CORS_ALLOW_ALL_ORIGINS = True

# Debug toolbar configuration - ONLY if installed
try:
    import debug_toolbar
    # Add debug toolbar to INSTALLED_APPS
    INSTALLED_APPS = list(INSTALLED_APPS) + ['debug_toolbar']
    
    # Add debug toolbar middleware
    MIDDLEWARE = ['debug_toolbar.middleware.DebugToolbarMiddleware'] + list(MIDDLEWARE)
    
    # Configure internal IPs
    INTERNAL_IPS = ['127.0.0.1']
    
    # Debug toolbar settings
    DEBUG_TOOLBAR_CONFIG = {
        'SHOW_TOOLBAR_CALLBACK': lambda request: True,
    }
except ImportError:
    print("Debug toolbar not installed. Skipping...")