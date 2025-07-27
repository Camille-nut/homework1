from app.models import UserInfo
from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserChangeForm, UserCreationForm, PasswordChangeForm


# 用户注册
class UserCreateForm(UserCreationForm):
    phone = forms.CharField(max_length=11, required=True, help_text='请输入您的电话号码',label='电话',)
    grade = forms.IntegerField(required=True, help_text='请输入您的班级',label='班级',)
    class_name = forms.IntegerField(required=True, help_text='请输入您的年级',label='年级',)
    class Meta:
        model = User
        fields = ("username",'email','phone','grade','class_name')
        widgets = {
            'email': forms.EmailInput(attrs={'class': 'form-control', 'id': 'floatingInput', 'placeholder': '邮箱'}),
            'phone': forms.CharField(widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': '电话'}))  #
        }

    def __init__(self, *args, **kwargs):
        super(UserCreateForm, self).__init__(*args, **kwargs)
        for field_name, field in self.fields.items():
            field.widget.attrs['class'] = 'form-control'

    def save(self, commit=True):
        user = super(UserCreateForm, self).save(commit=False)
        user_ = UserInfo(user=user, phone=self.cleaned_data["phone"],grade=self.cleaned_data["grade"],class_name=self.cleaned_data["class_name"])
        if commit:
            user.save()
            user_.save()
        return user


# 用户登入信息
class UserForm(forms.ModelForm):
    username = forms.CharField(max_length=50, required=True, help_text='请输入您的用户名',label='用户名',)
    class Meta:
        model = User
        fields = ( "password",)
        widgets = {
            'password': forms.PasswordInput(
                attrs={'class': 'form-control', 'id': 'floatingPassword', 'placeholder': '密码'}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field_name, field in self.fields.items():
            field.widget.attrs['class'] = 'form-control'


from django import forms
class CartAddForm(forms.Form):
    quantity = forms.IntegerField(widget=forms.NumberInput(attrs={'class': 'form-control', 'min': '1'}))

    # 更新信息模块
class ProfileUpdateForm(forms.ModelForm):
    address = forms.CharField(max_length=50, required=True,label='地址')
    phone = forms.CharField(max_length=11, required=True, help_text='请输入您的电话号码', label='电话', )
    grade = forms.IntegerField(required=True, help_text='请输入您的班级', label='班级', )
    class_name = forms.IntegerField(required=True, help_text='请输入您的年级', label='年级', )

    class Meta:
        model = User
        fields = ('username','email','phone','grade','class_name')

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field_name, field in self.fields.items():
            field.widget.attrs['class'] = 'form-control'
        user_info = kwargs.get('instance').userInfo
        self.fields['phone'] = forms.CharField(required=True, initial=user_info.phone if user_info else '', label='电话', widget=forms.TextInput(attrs={'class': 'form-control'}))
        self.fields['address'] = forms.CharField(required=True, initial=user_info.address if user_info else '', label='地址', widget=forms.TextInput(attrs={'class': 'form-control'}))
        self.fields['grade'] = forms.IntegerField(required=True, initial=user_info.grade if user_info else '', label='班级', widget=forms.TextInput(attrs={'class': 'form-control'}))
        self.fields['class_name'] = forms.IntegerField(required=True, initial=user_info.class_name if user_info else '', label='年级', widget=forms.TextInput(attrs={'class': 'form-control'}))

    def save(self, commit=True):
        # 首先保存 User 实例，如果需要的话
        user = super(ProfileUpdateForm, self).save(commit=False)
        # 尝试获取现有的 UserInfo 实例，如果不存在则创建一个新的实例
        try:
            user_info = UserInfo.objects.get(user=user)
        except UserInfo.DoesNotExist:
            user_info = UserInfo(user=user)

        # 更新 UserInfo 实例的字段
        user_info.phone = self.cleaned_data["phone"]
        user_info.address = self.cleaned_data["address"]
        user_info.grade = self.cleaned_data["grade"]
        user_info.class_name = self.cleaned_data["class_name"]

        # 如果设置了 commit 参数，则保存 UserInfo 实例
        if commit:
            user_info.save()

        return user

# 修改密码
class PasswordChangedForm(PasswordChangeForm):
    def __init__(self, *args, **kwargs):
        super(PasswordChangeForm, self).__init__(*args, **kwargs)
        for field_name, field in self.fields.items():
            field.widget.attrs['class'] = 'form-control'