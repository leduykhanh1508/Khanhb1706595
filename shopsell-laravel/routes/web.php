<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController; 
use App\Http\Controllers\Admincontroller; 
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

//Frontend
Route::get('/', [HomeController::class, 'index']);
Route::get('/trang-chu','App\Http\Controllers\HomeController@index');
//danh muc san pham trong trang chu
Route::get('/danh-muc-san-pham/{category_id}','App\Http\Controllers\CategoryProduct@show_category_home');
//danh muc san pham trong trang chu
Route::get('/thuong-hieu-san-pham/{brand_id}','App\Http\Controllers\BrandProduct@show_brand_home');
//chi tiet san pham
Route::get('/chi-tiet/{product_id}','App\Http\Controllers\ProductController@details_product');




//Backend
Route::get('/admin', [AdminController::class, 'index']);
Route::post('/admin_login','App\Http\Controllers\AdminController@index');
Route::get('/dashboard' ,'App\Http\Controllers\AdminController@show_dashboard');
Route::get('/logout','App\Http\Controllers\AdminController@logout');
Route::post('/admin_dashboard','App\Http\Controllers\AdminController@dashboard');

//Category Product
Route::get('/admin_product', [CategoryProduct::class, 'index']);
Route::get('/add-category-product','App\Http\Controllers\CategoryProduct@add_category_product');
Route::get('/all-category-product','App\Http\Controllers\CategoryProduct@all_category_product');
//Category Product status
Route::get('/inactive-category-product/{category_product_id}','App\Http\Controllers\CategoryProduct@inactive_category_product');
Route::get('/active-category-product/{category_product_id}','App\Http\Controllers\CategoryProduct@active_category_product');
//Category Product edit
Route::get('/edit-category-product/{category_product_id}','App\Http\Controllers\CategoryProduct@edit_category_product');
//Category Product delete
Route::get('/delete-category-product/{category_product_id}','App\Http\Controllers\CategoryProduct@delete_category_product');
//Category Product add
Route::post('/save-category-product','App\Http\Controllers\CategoryProduct@save_category_product');
//Category Product update
Route::post('/update-category-product/{category_product_id}','App\Http\Controllers\CategoryProduct@update_category_product');



//Brand Product
Route::get('/admin_product', [BrandProduct::class, 'index']);
Route::get('/add-brand-product','App\Http\Controllers\BrandProduct@add_brand_product');
Route::get('/all-brand-product','App\Http\Controllers\BrandProduct@all_brand_product');
//Brand Product status
Route::get('/inactive-brand-product/{brand_product_id}','App\Http\Controllers\BrandProduct@inactive_brand_product');
Route::get('/active-brand-product/{brand_product_id}','App\Http\Controllers\BrandProduct@active_brand_product');
//Brand Product edit
Route::get('/edit-brand-product/{brand_product_id}','App\Http\Controllers\BrandProduct@edit_brand_product');
//Brand Product delete
Route::get('/delete-brand-product/{brand_product_id}','App\Http\Controllers\BrandProduct@delete_brand_product');
//Brand Product save
Route::post('/save-brand-product','App\Http\Controllers\BrandProduct@save_brand_product');
//Brand Product update
Route::post('/update-brand-product/{brand_product_id}','App\Http\Controllers\BrandProduct@update_brand_product');


// Product
//Route::get('/admin_product', [ProductController::class, 'index']);
Route::get('/add-product','App\Http\Controllers\ProductController@add_product');
Route::get('/all-product','App\Http\Controllers\ProductController@all_product');
// Product status
Route::get('/inactive-product/{product_id}','App\Http\Controllers\ProductController@inactive_product');
Route::get('/active-product/{product_id}','App\Http\Controllers\ProductController@active_product');
// Product edit
Route::get('/edit-product/{product_id}','App\Http\Controllers\ProductController@edit_product');
// Product delete
Route::get('/delete-product/{product_id}','App\Http\Controllers\ProductController@delete_product');
// Product save
Route::post('/save-product','App\Http\Controllers\ProductController@save_product');
// Product update
Route::post('/update-product/{product_id}','App\Http\Controllers\ProductController@update_product');


//Cart
Route::post('/save-cart','App\Http\Controllers\CartController@save_cart');
Route::post('/update-cart-quantity','App\Http\Controllers\CartController@update_cart_quantity');
Route::get('/show-cart','App\Http\Controllers\CartController@show_cart');
Route::get('/delete-to-cart/{product_id}','App\Http\Controllers\CartController@delete_to_cart');



//Check out
Route::get('/checkout', [CheckoutController::class, 'index']);
Route::get('/login-checkout','App\Http\Controllers\CheckoutController@login_checkout');
Route::get('/logout-checkout','App\Http\Controllers\CheckoutController@logout_checkout');
Route::post('/add-customer','App\Http\Controllers\CheckoutController@add_customer');
Route::post('/login-customer','App\Http\Controllers\CheckoutController@login_customer');
Route::post('/order-place','App\Http\Controllers\CheckoutController@order_place');
Route::get('/checkout','App\Http\Controllers\CheckoutController@checkout');
Route::post('/save-checkout-customer','App\Http\Controllers\CheckoutController@save_checkout_customer');
Route::get('/payment','App\Http\Controllers\CheckoutController@payment');
Route::get('/manage-order','App\Http\Controllers\CheckoutController@manage_order');
Route::get('/view-order/{orderId}','App\Http\Controllers\CheckoutController@view_order');




