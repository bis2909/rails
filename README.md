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