# Setup ban đầu

Thiệt lập ban đầu cho Rails
+ Sử dụng Boostrap
+ Dùng `gem 'devise'` để login

## 1. Tạo dự án

Đầu tiên ta tạo thư mục là tên của dự án, ở đây sẽ dùng tên là `rails-1`, thư mục chứa dự án tên là Workspace

```
$ mkdir ~/Workspace/rails-1
$ cd ~/Workspace/rails-1
```

## 2. Thiết lập RVM

Ở đâu ta sử dụng RVM để quản lý ruby

```
$ echo ruby-2.3.1 > .ruby-version
$ echo rails-1 > .ruby-gemset
```

ở đây sẽ tạo ra 2 file, 1 file là tên ruby version, 1 file là tên dự án dành cho thiết lập ban đầu của rails thông qua RVM

## 3. Install Rails

```
$ gem install rails --no-rdoc --no-ri
$ rails new . -T -d=postgresql
```

Dòng đầu tiên là để install rails 2 tùy chọn là không cần cài doc làm việc install chạy nhanh hơn.

Dòng thứ 2 là tạo mới 1 dự án rails và sử dụng postgresql thay vì sqllite-3 như mặc định.

Sau khi chạy cài đặt xong chạy lệnh `$ rake db:create db:migrate`, để tạo database. Chạy `$ rails s` để khởi động dự án, truy cập `localhost:3000`

![rails-1-begin.png](http://sv1.upsieutoc.com/2017/08/11/rails-1-begin.png)

## 4. Install gem slim

### Gem slim

Dùng để viết html một cách gắn gọn thay cho mặc định của rails là erb. Tìm hiểu thêm tại [https://github.com/slim-template/slim](https://github.com/slim-template/slim)

Thêm vào `Gemfile`

`gem 'slim'`

Vào console chạy

`$ bundle install`

### Gem html2slim

Dùng để chuyển tất cả các file view sang slim. Ta chỉ dùng trong môi trường dev, nên sẽ add vào group :development. Xem thêm tại [https://github.com/slim-template/html2slim](https://github.com/slim-template/html2slim)

Thêm vào `Gemfile` ở trong `group :development`

`gem 'html2slim'`

Vào console chạy

```
$ bundle install
$ erb2slim -d .
```

Tất cả các file trong view sẽ chuyển sang html.slim

## 5. Tạo hompage đơn giản

### Controller

Tạo controller `app/controllers/home_controller.rb`

```
class HomeController < ApplicationController
  def index; end
end
```

Tạo view `app/views/home/index.html.slim`

```
#home-index-container
  .container
    h1 Homepage
```

Thêm vào routes `app/config/routes.rb`

```
root 'home#index'
```

Restart lại sever và chạy thử

![rails-1-homepage-simple.png](http://sv1.upsieutoc.com/2017/08/11/rails-1-homepage-simple.png)

## 6. Setup for asset simple

Thêm vào jquery, jquery-ui, boostrap vào dự án

+ Thêm vào Gemfile

```
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'bootstrap-sass'
```

Chạy bundle trong console `$ bundle`

+ Tạo các file scss căn bản
    * app/stylesheets/_mixins.scss
    * app/stylesheets/_variable.scss
    * app/stylesheets/fonts.scss

+ Update app/stylesheets/application.scss

```
@import "_mixins";
@import "_variables";
@import "fonts";
@import "jquery-ui";
@import "bootstrap-sprockets";
@import "bootstrap";
```

+ Update app/javascripts/application.js

```
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap-sprockets
```

+ Tạo app/views/layouts/_head.html.slim

```
title Rails-1
meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'
meta http-equiv='X-UA-Compatible' content='IE=10; IE=11'
meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
= csrf_meta_tags
= stylesheet_link_tag    'application', media: 'all'
= javascript_include_tag 'application'
```

+ Update app/views/layouts/application.html.slim

```
doctype html
html
  head = render 'layouts/head'
  body
    = yield
```

## 7. Tạo simple menu bằng boostrap

+ Tạo app/views/layouts/_header.html.slim

```
.layouts-header-container
  = render 'layouts/menu'
```

+ Tạo app/views/layouts/_menu.html.slim

```
.layouts-menu-container
  nav.navbar.navbar-default.navbar-static-top
    .container
      .navbar-header
        button.navbar-toggle.collapsed data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar"
          span.sr-only Toggle navigation
          span.icon-bar
          span.icon-bar
          span.icon-bar
        = link_to 'Rails-1', root_path, class: 'navbar-brand'
      #navbar.navbar-collapse.collapse
        ul.nav.navbar-nav
          li.active = link_to 'Home', root_path
          li = link_to 'About Us', 'javascript:'
          li = link_to 'Contact Us', 'javascript:'
        ul.nav.navbar-nav.navbar-right
          li = link_to 'Login', 'javascript:'
          li = link_to 'Register', 'javascript:'
```

+ Tạo app/views/layouts/_footer.html.slim

```
.layouts-footer-container
  .container
    p.text-muted Copyright © #{Time.now.year}. All Rights Reserved
```

+ Update cấu trúc app/views/layouts/application.html.slim

```
doctype html
html
  head = render 'layouts/head'
  body
    header
      = render 'layouts/header'
    main
      = yield
    footer
      = render 'layouts/footer'

```

+ Tạo app/stylesheets/global.scss

```
body {
  padding-bottom: 60px;
  position: relative;
  min-height: 100vh;

  footer {
    position: absolute;
    bottom: 0;
    width: 100%;
    height: 60px;
    background-color: #f5f5f5;

    p.text-muted {
      margin: 20px 0;
      text-align: center;
    }
  }
}
```

+ Add global.scss vào application.scss

```
@import "global";
```

Test lại

![rails-1-add-simple-menu.png](http://sv1.upsieutoc.com/2017/08/12/rails-1-add-simple-menu.png)