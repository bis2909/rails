# Setup ban đầu

Thiệt lập ban đầu cho Rails
+ Sử dụng Boostrap
+ Dùng `gem 'devise'` để login

## 1. Tạo dự án

Đầu tiên ta tạo thư mục là tên của dự án, ở đây sẽ dùng tên là `rails-1`, thư mục chứa dự án tên là Workspace

```
$ mkdir ~/Workspace/awesome-project
$ cd ~/Workspace/awesome-project
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