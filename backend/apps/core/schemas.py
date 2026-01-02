import graphene
from graphene_django import DjangoObjectType
from django.contrib.auth import get_user_model
from .models import Profile

User = get_user_model()


class UserType(DjangoObjectType):
    class Meta:
        model = User
        exclude = ('password', 'groups', 'user_permissions', 'is_superuser')


class ProfileType(DjangoObjectType):
    class Meta:
        model = Profile
        fields = '__all__'


class Query(graphene.ObjectType):
    users = graphene.List(UserType)
    user_by_id = graphene.Field(UserType, id=graphene.Int(required=True))
    me = graphene.Field(UserType)
    profiles = graphene.List(ProfileType)
    
    def resolve_users(self, info):
        return User.objects.all()
    
    def resolve_user_by_id(self, info, id):
        return User.objects.get(id=id)
    
    def resolve_me(self, info):
        user = info.context.user
        if user.is_anonymous:
            raise Exception("Not authenticated!")
        return user
    
    def resolve_profiles(self, info):
        return Profile.objects.all()


class CreateUser(graphene.Mutation):
    user = graphene.Field(UserType)
    
    class Arguments:
        username = graphene.String(required=True)
        email = graphene.String(required=True)
        password = graphene.String(required=True)
        first_name = graphene.String()
        last_name = graphene.String()
    
    def mutate(self, info, username, email, password, **kwargs):
        user = User(
            username=username,
            email=email,
            **kwargs
        )
        user.set_password(password)
        user.save()
        return CreateUser(user=user)


class UpdateUser(graphene.Mutation):
    user = graphene.Field(UserType)
    
    class Arguments:
        user_id = graphene.Int(required=True)
        phone = graphene.String()
        bio = graphene.String()
    
    def mutate(self, info, user_id, **kwargs):
        user = info.context.user
        if not user.is_authenticated:
            raise Exception("Not authenticated!")
        
        # Only allow users to update their own profile
        if user.id != user_id and not user.is_staff:
            raise Exception("Cannot update other users!")
        
        user_to_update = User.objects.get(id=user_id)
        for key, value in kwargs.items():
            setattr(user_to_update, key, value)
        user_to_update.save()
        return UpdateUser(user=user_to_update)


class Mutation(graphene.ObjectType):
    create_user = CreateUser.Field()
    update_user = UpdateUser.Field()