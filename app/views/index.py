from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.db.models import Q, Sum
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect, get_object_or_404
from django.urls import reverse
from app.forms import CartAddForm
from app.models import Category, Product, CartItem, Order, OrderItem, Favorite, Product_score

# 产品详情页
@login_required
def product_detail(request, pk):
    product = get_object_or_404(Product, pk=pk)
        # 检测用户是否收藏
    is_favorited = Favorite.objects.filter(user=request.user, product=product).exists()
    # 提交购物车
    if request.method == 'POST':
        form = CartAddForm(request.POST)
        if form.is_valid():
            quantity = form.cleaned_data['quantity']
            # 创建或更新购物车项
            if request.user.is_authenticated:
                cart_item, created = CartItem.objects.get_or_create(user=request.user, product=product)
                cart_item.quantity = quantity
                cart_item.save()

                # 商品评分 加 3
                product_score, score_created = Product_score.objects.get_or_create(user=request.user,product=product)
                product_score.score += 3
                product_score.save()
                return redirect('cart')
            else:
                # 如果用户未登录，处理逻辑可能不同，例如使用 session 或 cookie
                pass
            return redirect('product_detail', pk=product.pk)
    else:
        form = CartAddForm()

        # 浏览量 +1
        product.view_count += 1
        product.save()
        # 商品评分+1
        product_score, score_created = Product_score.objects.get_or_create(user=request.user, product=product)
        product_score.score += 1
        product_score.save()

    return render(request, 'product_detail.html', {'product': product, 'form': form,'is_favorited':is_favorited})

# 购物车
@login_required
def cart(request):
    cart_items = CartItem.objects.filter(user=request.user)
    if request.method == 'POST':
        if 'cart_items' in request.POST:
            cart_item_ids = request.POST.getlist('cart_items')
            order = Order(user=request.user)
            order.save()
            for cart_id in cart_item_ids:
                try:
                    cart_item = CartItem.objects.get(id=cart_id)
                    quantity = request.POST.get(f'quantity_{cart_item.id}')
                    # 如果库存不足
                    if cart_item.product.stock < int(quantity):
                        return redirect(reverse('order_success', args=[order.id]))  # 重定向到订单失败页面
                    # 创建订单
                    OrderItem.objects.create(
                        order=order,
                        product=cart_item.product,
                        quantity=quantity,
                    )
                    # 清楚购物车栏
                    cart_item.delete()
                    # 更新库存
                    cart_item.product.stock -= int(quantity)
                    cart_item.product.save()
                except OrderItem.DoesNotExist:
                    pass  # 如果项不存在，则忽略
            return redirect(reverse('order_success', args=[order.id]))  # 重定向到订单成功页面
        elif 'update' in request.POST:
            # 更新购物车
            for cart_item in cart_items:
                quantity = request.POST.get(f'quantity_{cart_item.id}')
                cart_item.quantity = int(quantity) if quantity else 1
                cart_item.save()
            return redirect('cart')
        elif 'delete' in request.POST:
            # 获取所有被选中的项的 ID
            cart_item_ids = request.POST.getlist('delete')
            for cart_item_id in cart_item_ids:
                try:
                    cart_item = CartItem.objects.get(id=cart_item_id)
                    cart_item.delete()
                except CartItem.DoesNotExist:
                    pass  # 如果项不存在，则忽略
            return redirect('cart')
    else:
        cart_items = CartItem.objects.filter(user=request.user)
        total = sum(item.product.price * item.quantity for item in cart_items)
        context = {
            'cart_items': cart_items,
            'total': total,
        }
        return render(request, 'cart.html', context)


# 提交订单
@login_required
# 提交订单成功
def order_success(request,order_id):
    # 假设订单成功后，返回订单成功页面
    order = Order.objects.get(id=order_id)
    context = {'order': order,'total_cost':order.get_total_cost(),'title':'您的订单已经提交成功','flag':'order'}
    return render(request, 'order_success.html', context)

# 订单失败
@login_required
# 提交订单成功
def order_fail(request):
    # 假设订单成功后，返回订单成功页面
    context = {'title':'订单创建失败，请检查库存'}
    return render(request, 'order_fail.html',context)

@login_required
# 取消订单成功
def unorder_success(request,order_id):
    # 假设订单成功后，返回订单成功页面
    order = Order.objects.get(id=order_id)
    order.status = '已取消'
    order.save()
    context = {'order': order,'total_cost':order.get_total_cost(),'title':'您的订单已经取消成功','flag':'unorder'}
    return render(request, 'order_success.html', context)

@login_required
# 支付成功
def process_payment(request, order_id):
    # 这里添加支付逻辑，比如调用支付网关
    # 以下代码仅为示例，实际项目中需要替换为真实的支付逻辑
    try:
        order = Order.objects.get(id=order_id)
        # 假设支付成功后，设置订单为完成状态
        order.status = '已支付'
        order.save()
        # 商品评分+4
        for item in order.orderitem.all():
            product_score, score_created = Product_score.objects.get_or_create(user=request.user, product=item.product)
            if score_created:
                product_score.score += 4
                product_score.save()
        return render(request, 'pay_success.html',{'order':order})
    except:
        return HttpResponse("支付处理错误", status=400)

@login_required
# 我的订单
def order_list(request):
    orders = Order.objects.filter(user=request.user)
    context = {
        'orders': orders,
    }
    return render(request, 'order_list.html', context)

@login_required
# 订单详情
def order_detail(request, order_id):
    order = Order.objects.get(user=request.user, id=order_id)
    context = {
        'order': order,
    }
    return render(request, 'order_detail.html', context)

# 收藏
@login_required
def toggle_favorite(request, product_id):
    product = get_object_or_404(Product, id=product_id)
    # 这里添加你的逻辑来切换收藏状态
    # 例如，如果有一个 Favorite 模型来存储收藏的商品
    favorite, created = Favorite.objects.get_or_create(user=request.user, product=product)
    product_score , score_created= Product_score.objects.get_or_create(user=request.user, product=product)
    if not created:
        product_score.score -= 2
        product_score.save()
        favorite.delete()
    else:
        # 给商品收藏加2分
        product_score.score += 2
        product_score.save()
        favorite.save()
    is_favorited = Favorite.objects.filter(user=request.user, product=product).exists()
    return JsonResponse({'isFavorited': is_favorited})

@login_required
# 热门
def hot_products(request):

    # 计算每个商品的总热度
    product_scores = Product_score.objects.filter(score__gt=0).values('product').annotate(total_score=Sum('score'))

    # 获取总热度排名前十的商品
    top_10_hot_products = product_scores.order_by('-total_score')[:10]

    # 获取热门商品的ID列表
    hot_product_ids = [item['product'] for item in top_10_hot_products]

    # 获取最近购买的商品，这里假设我们只取最新的5个订单的商品
    recent_items = OrderItem.objects.filter(
        Q(product_id__in=hot_product_ids) &
        Q(order__user=request.user)
    ).select_related('product').order_by('-date_added')[:5]
    products = Product.objects.filter(id__in=[item.product.id for item in recent_items])
    # 自己最近购买商品 以及热度
    recent_products = products.annotate(total_score=Sum('product_score__score')).order_by('-total_score')
    query = request.GET.get('q')
    # 如果没有查询参数，只按照category_id排序
    products = Product.objects.filter(
        id__in=hot_product_ids
    ).order_by('category_id').annotate(total_score=Sum('product_score__score'))
    if query:
        products = Product.objects.filter(
            Q(id__in=hot_product_ids) &
            Q(name__icontains=query)
        ).order_by('category_id').annotate(total_score=Sum('product_score__score'))
    categories = Category.objects.all()

    # 如果有分类选择，过滤商品
    category_id = request.GET.get('category')
    selected_category = None  # 记录选中的分类
    if category_id:
        try:
            selected_category = Category.objects.get(id=category_id)
            products = products.filter(
                Q(id__in=hot_product_ids) & Q(category=selected_category))
        except Category.DoesNotExist:
            products = Product.objects.none()

    # 按照热度排序
    products = products.order_by('-total_score')
    # 分页
    paginator = Paginator(products, 6)  # 每页显示10个商品
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'categories': categories,
        'products': page_obj,
        'selected_category': selected_category,
        'recent_products': recent_products,
    }
    return render(request, 'hot_products.html', context)


@login_required
def collect(request):
    # 获取当前用户的收藏项
    favorites = Favorite.objects.filter(user=request.user).select_related('product')

    # 将收藏项传递给模板
    context = {
        'favorites': favorites,
    }
    return render(request, 'collect.html', context)


