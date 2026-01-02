class CustomGraphQLMiddleware:
    def resolve(self, next, root, info, **args):
        # Add custom middleware logic here
        return next(root, info, **args)