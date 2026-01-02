import graphene
from graphene_django import DjangoObjectType
from .models import Category, Product, Review


class CategoryType(DjangoObjectType):
    class Meta:
        model = Category
        fields = '__all__'


class ProductType(DjangoObjectType):
    class Meta:
        model = Product
        fields = '__all__'


class ReviewType(DjangoObjectType):
    class Meta:
        model = Review
        fields = '__all__'


class Query(graphene.ObjectType):
    categories = graphene.List(CategoryType)
    products = graphene.List(ProductType)
    product = graphene.Field(ProductType, id=graphene.Int(required=True))
    
    def resolve_categories(self, info):
        return Category.objects.all()
    
    def resolve_products(self, info):
        return Product.objects.filter(is_active=True)
    
    def resolve_product(self, info, id):
        return Product.objects.get(id=id, is_active=True)


class CreateProduct(graphene.Mutation):
    product = graphene.Field(ProductType)
    
    class Arguments:
        name = graphene.String(required=True)
        description = graphene.String(required=True)
        price = graphene.Decimal(required=True)
        category_id = graphene.Int(required=True)
        stock = graphene.Int()
    
    def mutate(self, info, **kwargs):
        user = info.context.user
        if not user.is_staff:
            raise Exception("Only staff can create products")
        
        category = Category.objects.get(id=kwargs.pop('category_id'))
        product = Product(category=category, **kwargs)
        product.save()
        return CreateProduct(product=product)


class Mutation(graphene.ObjectType):
    create_product = CreateProduct.Field()