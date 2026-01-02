import graphene
import backend.apps.core.schemas as core_schema
import backend.apps.products.schemas as products_schema
#import backend.apps.orders.schemas as orders_schema
from graphql_jwt import ObtainJSONWebToken, Refresh, Verify


class Query(
    core_schema.Query,
    products_schema.Query,
    #orders_schema.Query,
    graphene.ObjectType
):
    pass


class Mutation(
    core_schema.Mutation,
    products_schema.Mutation,
    #orders_schema.Mutation,
    graphene.ObjectType
):
    token_auth = ObtainJSONWebToken.Field()
    verify_token = Verify.Field()
    refresh_token = Refresh.Field()


schema = graphene.Schema(query=Query, mutation=Mutation)