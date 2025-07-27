from django.contrib.auth import authenticate
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.db.models import Q
from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login as login_view, update_session_auth_hash
from app.forms import UserCreateForm, UserForm, PasswordChangedForm, ProfileUpdateForm
from app.models import Category, Product, CartItem, Order, OrderItem, Product_score

@login_required
# 热门
def index(request):
    # 获取最近购买的商品，这里假设我们只取最新的5个订单的商品
    recent_items = OrderItem.objects.filter(order__user=request.user).select_related('product').order_by('-date_added')[
                   :5]
    recent_products = [item.product for item in recent_items]  # 获取商品实例列表

    # 获取排名前十的热门商品
    query = request.GET.get('q')
    products = Product.objects.all().order_by('category_id')
    if query:
        products = products.filter(name__icontains=query)
    categories = Category.objects.all()

    # 如果有分类选择，过滤商品
    category_id = request.GET.get('category')
    selected_category = None  # 记录选中的分类
    if category_id:
        try:
            selected_category = Category.objects.get(id=category_id)
            products = products.filter(category=selected_category)
        except Category.DoesNotExist:
            products = Product.objects.none()

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
    return render(request, 'index.html', context)



def login(request, *args, **kwargs):
    if request.method == 'POST':
        form = UserForm(request.POST)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')
            user = authenticate(request, username=username, password=password)
            if user is not None:
                login_view(request, user)
                return redirect('index')  # 重定向到首页或其他页面
            else:
                # 验证失败
                return render(request, 'login.html', {'form': form, 'message': '用户名或密码错误'})
        else:
            # 表单数据无效
            print(form.errors)
            return render(request, 'login.html', {'form': form})
    else:
        form = UserForm()
        # 非POST请求，返回登录页面
        return render(request, 'login.html',{'form': form})


def register(request,*args, **kwargs):
    if request.method == 'POST':
        form = UserCreateForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('login')  # 重定向到登录页面或其他页面
        else:
            # 验证失败
            return render(request, 'register.html', {'form': form})
    else:
        form = UserCreateForm()
        # 非POST请求，返回注册页面
        return render(request, 'register.html',{'form': form})

@login_required
def logout(request):
    # 清除用户会话
    request.session.clear()
    # 可以选择重定向到登录页面或主页
    return redirect('login')

@login_required
def profile_update(request):
    if request.method == 'POST':
        form = ProfileUpdateForm(request.POST, instance=request.user)
        if form.is_valid():
            form.save()
            return redirect('profile_update')
    else:
        form = ProfileUpdateForm(instance=request.user)
    return render(request, 'profile_update.html', {'form': form})

@login_required
def change_password(request):
    if request.method == 'POST':
        form = PasswordChangedForm(request.user, request.POST)
        if form.is_valid():
            user = form.save()
            update_session_auth_hash(request, user)  # 重置 session
            logout(request)  # 注销用户
            return redirect('login')
        else:
            return render(request, 'password_change.html', {'form': form})
    else:
        form = PasswordChangedForm(request.user)
    return render(request, 'password_change.html', {'form': form})
