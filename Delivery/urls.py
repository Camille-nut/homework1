"""Delivery URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
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
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.views.static import serve
from django.urls import path, re_path
from app.views import account, index, recommd, chart

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', account.login, name='login'),
    path('index/', account.index, name='index'),
    path('login/', account.login, name='login'),
    path('logout/', account.logout, name='logout'),
    path('register/', account.register, name='register'),
    re_path('media/(?P<path>.*)$', serve, {'document_root': settings.MEDIA_ROOT}),
    path('profile/update/', account.profile_update, name='profile_update'),
    path('password/change/', account.change_password, name='password_change'),
      path('product/detail/<int:pk>/', index.product_detail, name='product_detail'),
      path('cart/', index.cart, name='cart'),
      path('order/success/<int:order_id>/',index.order_success, name='order_success'),
      path('order/fail/',index.order_fail, name='order_fail'),
      path('unorder/success/<int:order_id>/', index.unorder_success, name='unorder_success'),
      path('order/process_payment/<int:order_id>/', index.process_payment, name='process_payment'),
      path('orders/', index.order_list, name='order_list'),
      path('orders/<int:order_id>/', index.order_detail, name='order_detail'),
      path('toggle_favorite/<int:product_id>/', index.toggle_favorite, name='toggle_favorite'),
      path('product/hot/', index.hot_products, name='hot'),
      path('product/collect/', index.collect, name='collect'),
      path('product/recommend/', recommd.recommend, name='recommend'),
      path('today/chart/', chart.today_chart, name='today_chart'),
      path('echart1/', chart.top_viewed_products, name='echart1'),
      path('echart2/', chart.order_rank, name='echart2'),
      path('echart3/', chart.favorite_rank, name='echart3'),
      path('echart4/', chart.daily_order_volume, name='echart4'),
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
