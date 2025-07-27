import os
from math import *
import time

from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.db.models import Q
from django.http import JsonResponse
from django.shortcuts import render, redirect
from app import models
from app.models import Product_score, Product, User, OrderItem, Category


def getdata():#获取数据
    alldata=Product_score.objects.values_list('user','product','score')
    data={}
    # for i in alldata:
    #     if not i[0] in data.keys():
    #         data[i[0]]={i[1]:i[2]}
    #     else:
    #         data[i[0]][i[1]]=i[2]
    for user, product, score in alldata:
        if user not in data:
            data[user] = {}
        data[user][product] = score
    return data

#计算用户相似度
def Euclid(user1,user2):#尤几里得距离也就是欧式距离
    #取出两个用户都查看过的的职位
    data=getdata()
    print('data',data)
    user1_data = data.get(user1, {})
    user2_data = data.get(user2, {})
    #默认距离,相似度越大距离越短
    distance=0
    #遍历找出相同职位
    for key in user1_data.keys():
        if key in user2_data.keys():
            distance+=pow(float(user1_data[key])-float(user2_data[key]),2)
    return 1/(1+sqrt(distance))
#计算某用户和其他用户相似度的比对
def top_simliar(user):
    res=[]
    data=getdata()
    for userid in data.keys():
        #首先排除当前用户
        if not userid==user:
            simliar=Euclid(user,userid)
            res.append((userid,simliar))
    res.sort(key=lambda val:val[1],reverse=True)
    return res,data
def recommend(request):#给用户推荐职位方法
    # id =request.session.get('user').get('id')
    #print(top_simliar(id))
    user = request.user
    res,data=top_simliar(user.id)
    print('res+data',res,data)
    workid={}
    try:
        for i in range(5):
            top_user=res[i][0]
            #print(top_user)
            #print(data[top_user])
            workid.update(data[top_user])
    except:
        pass
    #print(workid)
    recommend_list=[]
    workid=sorted(workid.items(),key=lambda x:x[1],reverse=True)[:10]#给列表按打分排序,取出前十个推荐
    for i in workid:
        recommend_list.append(i[0])

    if len(recommend_list) == 0:
        product_scores = Product_score.objects.values_list('product', flat=True)
        recommend_list = list(product_scores)
    print(recommend_list)
    products= Product.objects.filter(id__in=recommend_list)

    # 获取最近购买的商品，这里假设我们只取最新的5个订单的商品
    recent_items = OrderItem.objects.filter(
        Q(product_id__in=recommend_list) &
        Q(order__user=request.user)
    ).select_related('product').order_by('-date_added')[:5]
    recent_products = Product.objects.filter(id__in=[item.product.id for item in recent_items])


    if products:

        query = request.GET.get('q')
        if query:
            products = products.filter(name__icontains=query)

        categories = Category.objects.all()
        # 如果有分类选择，过滤商品
        category_id = request.GET.get('category')
        selected_category = None  # 记录选中的分类
        if category_id:
            try:
                selected_category = Category.objects.get(id=category_id)
                products = products.filter(
                    Q(id__in=recommend_list) & Q(category=selected_category))
            except Category.DoesNotExist:
                products = Product.objects.none()

        paginator = Paginator(products, 10)
        page = request.GET.get('page')

        try:
            page_obj = paginator.page(page)
        except PageNotAnInteger:
            page_obj = paginator.page(1)
        except EmptyPage:
            page_obj = paginator.page(paginator.num_pages)
        print(page_obj)

        context = {
            'recent_products':recent_products,
             'categories': categories,
            'products': page_obj,
            'selected_category': selected_category,
        }

        return render(request,'recommend.html',context)
    return render(request, 'recommend.html')
