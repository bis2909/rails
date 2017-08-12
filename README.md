# Setup ban đầu

Thiệt lập ban đầu cho Rails
+ Sử dụng Boostrap
+ Dùng `gem 'devise'` để login

Từng bước để tạo dự án căn bản với rails

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

## 8. Setup popup helper để show popup message

Add view cho popup message `app/views/popups/_template.html.slim`

```
#popup.modal.fade role='dialog'
  .public-popups-template.modal-dialog
    .modal-content
      .modal-header
        button.close aria-label="Close" data-dismiss="modal" type="button"
          span aria-hidden="true"  &times;
        h4.modal-title
      .modal-body
```

Add `app/views/popups/_popup.js.erb`

```
if($('#popup').length == 0) {
  $('body').prepend("<%= j render 'popups/template' %>")
}

$('#popup .modal-body').html("<%= j render render_path, locals %>");
$('#popup .modal-title').html("<%= j title %>")
$('#popup').modal('show')
$('#popup').attr('class', "fade in modal <%= 'popups-' + (render_path.gsub! '/', '-') %>")
```

Add `app/views/popups/_confirm.js.erb`

```
if($('#popup_confirm').length == 0) {
  $('body').prepend("<%= j render 'popups/confirm_template' %>")
}

$('#popup_confirm .modal-body').html("<%= j render render_path, locals %>");
$('#popup_confirm .modal-title').html("<%= j title %>")
$('#popup_confirm').modal({
        backdrop: 'static',
        keyboard: false,
        show: true
      })
$('#popup_confirm').attr('class', "fade in modal <%= 'popups-' + (render_path.gsub! '/', '-') %>")
```

Add `app/views/popups/_confirm_template.html.slim`

```
#popup_confirm.modal.fade role='dialog'
  .public-popups-template.modal-dialog
    .modal-content
      .modal-header
        h4.modal-title
      .modal-body
```

Add `app/views/popups/_message.js.erb`

```
if($('#popup').length == 0) {
  $('body').prepend("<%= j render 'popups/template' %>")
}

$('#popup .modal-body').html("<%= j message %>");
$('#popup .modal-title').html("<%= j title %>")
$('#popup').modal('show')
$('#popup').attr('class', "fade in modal popups-message")
```

Thêm helper `app/helpers/popup_helper.rb`

```
module PopupHelper
  def open_popup(title: 'Message', partial: '', locals: {})
    render partial: 'popups/popup', locals: { title: title, render_path: partial, locals: locals }
  end

  def open_confirm(title: 'Message', partial: '', locals: {})
    render partial: 'popups/confirm', locals: { title: title, render_path: partial, locals: locals }
  end

  def open_message(flash, title: 'Message')
    messages = []

    flash.each do |type, message|
      messages << message
    end

    render partial: 'popups/message', locals: { title: title, message: messages.join("<br />").html_safe }, formats: :js if messages.any?
  end
end
```

Add `= javascript_tag open_message(flash)` vào application.html.slim `app/views/layouts/application.html.slim`

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
    = javascript_tag open_message(flash)
```

## 9. Add gem simple_form và devise

### Simple form gem

Thêm vào Gemfile

```
gem 'simple_form'
```

Chạy bundle `$ bundle install`

Chạy generator:

```
$ rails generate simple_form:install
$ rails generate simple_form:install --bootstrap
```

### Gem devise

Thêm vào Gemfile

```
gem 'devise'
```

Sau đó chạy `$ bundle install` trong console

Chạy generator:

```
$ rails generate devise:install
```

Thêm config `config/environments/development.rb`, để thiết lập phương thức gửi mail, cần update phương thức cho production khi deploy.

```
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```

Chạy generate devise:

```
$ rails generate devise User
```

Update migrate `db/migrate/...._devise_create_users.rb`

```
class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
  end
end
```

Update file model `app/models/user.rb`

```
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
end
```

Generate view cho User:

```
$ rails generate devise:views users
```

Update config `config/initializers/devise.rb`

```
config.scoped_views = true
```

Chạy `$ erb2slim -d .` để chuyển erb sang slim.

Generate controller:

```
$ rails generate devise:controllers users
```

Do divese căn bản chỉ có email với password, ta cần thêm 2 field trong bảng User

```
$ rails g migration add_column_to_users
```

Update migrate `db/migrate/...._add_column_to_users.rb`

```
class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name,  :string
  end
end
```

Chạy migrate `$ rake db:migrate`

Add permit first_name và last_name `app/controllers/users/registrations_controller.rb`

```
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create
    build_resource(sign_up_params)

    if resource.save
      set_flash_message :notice, :signed_up_but_unconfirmed
      redirect_to root_url
    else
      render :new
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
```

Update view đăng ký user `app/views/users/registrations/new`

```
#users-registrations-new-container
  .container
    h2 Sign up
    = simple_form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f|
      = f.input :first_name
      = f.input :last_name
      = f.input :email
      = f.input :password, input_html: { autocomplete: 'off' }
      = f.input :password_confirmation, input_html: { autocomplete: 'off' }
      = f.submit "Sign up", class: 'btn btn-primary'
    = render "users/shared/links"
```

Update view login `app/views/users/sessions/new.html.slim`

```
#users-sessions-new-container
  .container
    h2 Log in
    = simple_form_for(resource, as: resource_name, url: session_path(resource_name)) do |f|
      = f.input :email, input_html: { autofocus: true }
      = f.input :password
      = f.input :remember_me, as: :boolean
      = f.submit 'Log in', class: 'btn'
    = render "users/shared/links"
```

Add gem 'letter_opener' để send mail dưới môi trường development:

```
gem 'letter_opener'
```

Chạy bundle `$ bundle install`

Add config trong môi trường development `config/environments/development.rb`

```
config.action_mailer.delivery_method = :letter_opener
```

Update `config/routes.rb`

```
Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'home#index'
end
```

Update link Register trong menu `app/views/layouts/_menu.html.slim`

```
ul.nav.navbar-nav.navbar-right
  - if user_signed_in?
    li = link_to 'Logout', destroy_user_session_path, method: :delete
  - else
    li = link_to 'Login', new_user_session_path
    li = link_to 'Register', new_user_registration_path
```

Demo SignUp

![rails-1-sign-up.png](http://sv1.upsieutoc.com/2017/08/12/rails-1-sign-up.png)

Đăng ký thành công

![rails-1-sign-up-success.png](http://sv1.upsieutoc.com/2017/08/12/rails-1-sign-up-success.png)

letter_opener sau khi đăng ký thành công

![rails-1-demo-send-mail.png](http://sv1.upsieutoc.com/2017/08/12/rails-1-demo-send-mail.png)