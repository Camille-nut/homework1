from django.db.models import Sum, Count
from django.db.models.functions import TruncDay
from django.shortcuts import render
from django.http import JsonResponse
from app.models import Product, OrderItem, Favorite, Order


def today_chart(request):
    return render(request, 'chart.html')


# 浏览量图表
def top_viewed_products(request):
    # 获取浏览量排名前十的商品
    # 获取浏览量大于0且排名前十的商品
    top_products = Product.objects.filter(view_count__gt=0).values('name', 'view_count').order_by('-view_count')[:10]
    context = {
        'top_products': [{'name': item['name'], 'value': item['view_count']} for item in top_products],
    }
    return JsonResponse(context)

# 订单排行图表
def order_rank(request):
    order_ranks = OrderItem.objects.select_related('product').values('product__name').annotate(
        total_quantity=Sum('quantity')).order_by('-total_quantity')[:10]

    # 将结果转换为 {name: '', quantity: ''} 格式
    order_ranks_list = [{'name': item['product__name'], 'quantity': item['total_quantity']} for item in order_ranks]

    # 返回 JSON 响应
    return JsonResponse({'order_ranks': order_ranks_list})

# 收藏图表
def favorite_rank(request):
    # 使用 annotate 计算每个商品的收藏次数
    favorite_counts = Favorite.objects.select_related('product').values('product__name').annotate(
        total_favorites=Count('product')).order_by('-total_favorites')[:10]

    # 将结果转换为 {name: '', quantity: ''} 格式
    favorite_ranks_list = [{'name': item['product__name'], 'quantity': item['total_favorites']} for item in
                           favorite_counts]

    # 返回 JSON 响应
    return JsonResponse({'favorite_ranks': favorite_ranks_list})
from django.utils import timezone

from datetime import timedelta

def daily_order_volume(request):
    # 计算日期范围：今天往回7天
    end_date = timezone.now()
    start_date = end_date - timedelta(days=7)

    # 获取近一周每日下单量
    daily_orders = Order.objects.filter(
        date_ordered__range=(start_date, end_date)
    ).values('date_ordered').annotate(
        total_orders=Count('id')
    ).order_by('date_ordered')

    # 将结果转换为列表，包含日期和下单量
    daily_orders_list = [{'date':item['date_ordered'].strftime('%Y-%m-%d'),'total_orders':item['total_orders']} for item in daily_orders]
    # 创建一个空字典来存储日期和对应的订单总数
    date_counts = {}

    # 遍历列表，聚合数据
    for item in daily_orders_list:
        date = item['date']
        if date in date_counts:
            date_counts[date] += 1
        else:
            date_counts[date] = 1

    # 将聚合结果转换为所需的格式
    result = [{"date": date, "total_orders": count} for date, count in date_counts.items()]

    # 返回JSON响应
    return JsonResponse({'daily_orders': result})