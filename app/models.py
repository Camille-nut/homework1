from django.db import models
# Create your models here.
import uuid
from django.db import models
from django.contrib.auth.models import User
# 用户表
class UserInfo(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, verbose_name='用户',related_name='userInfo')
    class_name = models.CharField(max_length=50, verbose_name='班级')  # 增加班级字段
    grade = models.CharField(max_length=50, verbose_name='年级')  # 增加年级字段
    phone = models.CharField(max_length=11, verbose_name='电话')
    address = models.CharField(max_length=255, verbose_name='地址')

    def __str__(self):
        return self.user.username

    class Meta:
        verbose_name = '用户信息'
        verbose_name_plural = '用户信息'
# 外卖类型分类表
class Category(models.Model):
    name = models.CharField(max_length=100, unique=True, verbose_name='分类名称')

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = '分类'
        verbose_name_plural = '分类'
# 外卖商品表
class Product(models.Model):
    category = models.ForeignKey(
        Category,
        on_delete=models.CASCADE,
        related_name='products',
        verbose_name='分类'
    )
    name = models.CharField(max_length=255, verbose_name='名称')
    price = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name='价格'
    )
    stock = models.IntegerField(verbose_name='库存')
    image = models.ImageField(
        upload_to='products/',
        blank=True,
        null=True,
        verbose_name='封面'
    )
    description = models.TextField(
        blank=True,
        null=True,
        verbose_name='描述'
    )
    view_count = models.IntegerField(verbose_name='浏览量',default=0)
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='创建日期')

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = '产品'
        verbose_name_plural = '产品'
# 用户收藏表
class Favorite(models.Model):
    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='favorites',
        verbose_name='用户'
    )
    product = models.ForeignKey(
        Product,
        on_delete=models.CASCADE,
        related_name='favorited_by',
        verbose_name='产品'
    )
    date_added = models.DateTimeField(auto_now_add=True, verbose_name='添加日期')

    def __str__(self):
        return f'{self.user.username} - {self.product.name}'

    class Meta:
        verbose_name = '用户收藏'
        verbose_name_plural = '用户收藏'
        unique_together = ('user', 'product')  # 确保每个用户只能收藏同一个产品一次
# 购物车表
class CartItem(models.Model):
    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        verbose_name='用户'
    )
    product = models.ForeignKey(
        Product,
        on_delete=models.CASCADE,
        verbose_name='产品'
    )
    quantity = models.IntegerField(default=1, verbose_name='数量')

    def __str__(self):
        return f"{self.quantity} of {self.product.name}"

    def get_total_price(self):
        return self.quantity * self.product.price

    class Meta:
        verbose_name = '购物车项'
        verbose_name_plural = '购物车项'

# 商品评分表
class Product_score(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    product = models.ForeignKey('Product', on_delete=models.CASCADE)
    score = models.IntegerField('热度', null=True,default=0)

    def __str__(self):
        return f'用户 {self.user.username} 对 {self.product.name} 的评分：{self.score}'

    class Meta:
        verbose_name = '商品评分'
        verbose_name_plural = '商品评分'

# 订单状态表
class Order(models.Model):
    # 定义订单状态的选项
    ORDER_STATUS_CHOICES = (
        ('未支付', '未支付'),
        ('已支付', '已支付'),
        ('已发货', '已发货'),
        ('已完成', '已完成'),
        ('已取消', '已取消'),
    )
    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        verbose_name='用户'
    )
    date_ordered = models.DateTimeField(
        auto_now_add=True,
        verbose_name='下单日期'
    )
    status = models.CharField(
        max_length=10,
        choices=ORDER_STATUS_CHOICES,
        default='未支付',
        verbose_name='订单状态'
    )

    transaction_id = models.CharField(
        max_length=100,
        default=uuid.uuid4(),
        blank=True,
        verbose_name='交易ID'
    )

    def __str__(self):
        return f"订单 {self.id} 用户 {self.user.username}"

    def get_total_cost(self):
        return sum(item.get_total_price() for item in self.orderitem.all())

    class Meta:
        verbose_name = '订单'
        verbose_name_plural = '订单'
# 用户订单数据表
class OrderItem(models.Model):
    order = models.ForeignKey(
        Order,
        on_delete=models.CASCADE,
        related_name='orderitem',
        verbose_name='订单'
    )
    product = models.ForeignKey(
        Product,
        on_delete=models.CASCADE,
        verbose_name='产品'
    )
    quantity = models.IntegerField(
        default=1,
        verbose_name='数量'
    )
    date_added = models.DateTimeField(
        auto_now_add=True,
        verbose_name='添加日期'
    )

    def __str__(self):
        return f"{self.quantity} of {self.product.name}"

    def get_total_price(self):
        return self.quantity * self.product.price

    class Meta:
        verbose_name = '订单项'
        verbose_name_plural = '订单项'
