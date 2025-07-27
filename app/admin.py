from django.contrib import admin

# Register your models here.

from django.contrib import admin
from django.shortcuts import redirect
from django.utils.html import format_html

from .models import UserInfo, Category, Product, Favorite, CartItem, Product_score, Order, OrderItem

# Register your models here.

admin.site.site_header = '校园外卖管理系统'  # 设置header
admin.site.site_title = '校园外卖管理系统'  # 设置title
admin.site.index_title = '校园外卖管理系统'


@admin.register(UserInfo)
class UserInfoAdmin(admin.ModelAdmin):
    list_display = ('user', 'class_name','grade','phone', 'address')  # 在列表页显示的字段
    search_fields = ('user__username', 'phone', 'address')  # 搜索框搜索的字段
    filter_fields = ('class_name','grade')


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name',)  # 在列表页显示的字段
    search_fields = ('name',)  # 搜索框搜索的字段

@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ('name','category','price','stock','image_tag','description','view_count','created_at')  # 在列表页显示的字段
    search_fields = ('name','category__name')  # 搜索框搜索的字段
    filter_fields = ('name','category__name')  # 过滤的字段
    list_display_links = ('name',) # 定义可以点击的链接字段

    def image_tag(self, obj):
        """
        如果 image 字段存在，则返回一个 HTML img 标签。
        """
        if obj.image:
            return format_html('<img src="{0}" width="100px" height="100px"/>', obj.image.url)
        return "-"

    image_tag.short_description = '封面'  # 设置列的标题

    # 确保 image_tag 方法被列表视图使用
    readonly_fields = ('image_tag',)

@admin.register(Favorite)
class FavoriteAdmin(admin.ModelAdmin):
    list_display = ('user','product','date_added')  # 在列表页显示的字段
    search_fields = ('user__username','product__name')  # 搜索框搜索的字段

@admin.register(CartItem)
class CartItemAdmin(admin.ModelAdmin):
    list_display = ('user','product','quantity')  # 在列表页显示的字段
    search_fields = ('user__username','product__name')  # 搜索框搜索的字段


@admin.register(Product_score)
class Product_scoreAdmin(admin.ModelAdmin):
    list_display = ('user', 'product', 'score')  # 在列表页显示的字段
    search_fields = ('user__username',)  # 搜索框搜索的字段

@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ('user', 'transaction_id','date_ordered', 'status')  # 在列表页显示的字段
    search_fields = ('user__username', 'transaction_id')  # 搜索框搜索的字段
    list_filter = ('status', 'date_ordered')  # 添加列表过滤
    actions = ['cancel_orders', 'ship_orders', 'complete_orders']

    def cancel_orders(self, request, queryset):
        count = queryset.filter(status='未支付').update(status='已取消')
        self.message_user(request, f"{count} 订单已取消。")

    cancel_orders.short_description = '取消订单'

    def ship_orders(self, request, queryset):
        count = queryset.filter(status='已支付').update(status='已发货')
        self.message_user(request, f"{count} 订单已发货。")

    ship_orders.short_description = '发货订单'

    def complete_orders(self, request, queryset):
        count = queryset.filter(status='已发货').update(status='已完成')
        self.message_user(request, f"{count} 订单已完成。")

    complete_orders.short_description = '完成订单'



@admin.register(OrderItem)
class OrderItemAdmin(admin.ModelAdmin):
    list_display = ('order', 'product', 'quantity')  # 在列表页显示的字段
    search_fields = ('order__user__username', 'product__name')  # 搜索框搜索的字段




