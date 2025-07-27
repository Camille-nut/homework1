# 校园外卖点菜平台  

## 项目介绍  
本项目是一个基于**B/S结构**的校园外卖点菜平台，采用 **Python+Django** 作为后端技术栈，**Vue.js** 作为前端框架。平台分为前台用户界面和后台管理系统两部分，为校园用户提供便捷的外卖点餐服务。  

---

## 功能模块  

### 前台功能  
- **首页** - 菜品展示与分类浏览  
- **菜品详情页** - 菜品详细信息查看  
- **订单中心** - 订单管理与跟踪  
- **用户中心** - 个人信息管理  

### 后台功能  
- **总览** - 数据统计与分析  
- **订单管理** - 处理用户订单  
- **菜品管理** - 菜品上架与维护  
- **分类管理** - 菜品分类设置  
- **标签管理** - 菜品标签设置  
- **评论管理** - 用户评论审核  
- **用户管理** - 用户信息管理  

---

## 代码结构  

├── server/ # 后端代码 (Python+Django)

├── web/ # 前端代码 (Vue.js)

├── app/ # Django应用模块

├── Delivery/ # 配送管理模块

├── media/ # 上传的媒体文件

├── static/ # 静态资源文件

├── templates/ # HTML模板文件

├── delivery.sql # 数据库初始化文件

└── manage.py # Django管理脚本


---

## 部署指南  

### 后端部署  
1. 安装 **Python 3.8**  
2. 安装依赖：  
   ```bash
   pip install -r requirements.txt
```
3. 配置 MySQL 5.7 数据库：

   ```sql
CREATE DATABASE shop DEFAULT CHARSET utf8mb4;
```
导入数据：
  ```sql
  mysql> use shop;
  mysql> source delivery.sql;
```
启动服务：
  ```bash
  python manage.py runserver
```
### 前端部署
1. 安装 Node.js 环境：
  ```bash
nvm install 16.14
nvm use 16.14
```

2. 进入项目目录并安装依赖：
```bash
cd web
npm install
```

3. 开发模式运行：
```bash
npm run dev
```
4. 生产环境构建：
```bash
npm run build
```
5. 本地预览生产版本：
 ```bash
npm install -g serve
serve -s dist
 ```
### 界面演示
![首页截图](e1e6141cfb67f6f87ea2f7971e96e344.jpg)
![点单界面](74f3448a9edae4903fd1866e35b01063.jpg)
![点单界面](19440d48133c4721fd2f8aa9c990ecaf.jpg)
![后台登陆](ff832562db32f95b96455665255444ad.jpg)
