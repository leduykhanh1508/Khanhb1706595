<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use Session;
use App\Http\Requests;
use App\Slider;
use App\CatePost;
use Illuminate\Support\Facades\Redirect;
use Cart;
use Carbon\Carbon;
use App\Coupon;
session_start();
class CartController extends Controller
{
    public function show_cart_menu(){
        $cart = count(Session::get('cart'));
        $output = '';
        $output.='<span class="badges">'.$cart.'</span>';
        echo $output;
    }
    public function delete_all_product(){
        $cart = Session::get('cart');
        if($cart==true){
                // Session::destroy();
            Session::forget('cart');
            Session::forget('coupon');
            return redirect()->back()->with('message','Xóa hết giỏ thành công');
        }
    }
    public function remove_item(Request $request){
        $data = $request->all();
        $cart = Session::get('cart');
           
        if($cart==true){
    
            foreach($cart as $key => $val){
                if($val['product_id']==$data['id']){
                    unset($cart[$key]);
                }
            }
            
            Session::put('cart',$cart);
        
        }
    
    }
    public function cart_session(){
   
        $output ='';
        
        if(Session::get('cart')==true){
            foreach(Session::get('cart') as $key => $value){
               
                $output.= '<input type="hidden" class="cart_id" value="'.$value['product_id'].'">';
            }
        }
        echo $output;
    }
    public function gio_hang(){
        $cate_product = DB::table('tbl_category_product')->where('category_status','1')->orderby('category_id','desc')->get(); 
        $brand_product = DB::table('tbl_brand')->where('brand_status','1')->orderby('brand_id','desc')->get(); 
        return view('pages.cart.cart_ajax')->with('category',$cate_product)->with('brand',$brand_product);
    }
    public function add_cart_ajax(Request $request){
        $data = $request->all();
        $session_id = substr(md5(microtime()),rand(0,26),5);
        $cart = Session::get('cart');
        if($cart==true){
            $is_avaiable = 0;
            foreach($cart as $key => $val){
                if($val['product_id']==$data['cart_product_id']){
                    $is_avaiable++;
                }
            }
            if($is_avaiable == 0){
                $cart[] = array(
                'session_id' => $session_id,
                'product_name' => $data['cart_product_name'],
                'product_id' => $data['cart_product_id'],
                'product_image' => $data['cart_product_image'],
                'product_qty' => $data['cart_product_qty'],
                'product_price' => $data['cart_product_price'],
                );
                Session::put('cart',$cart);
            }
        }else{
            $cart[] = array(
                'session_id' => $session_id,
                'product_name' => $data['cart_product_name'],
                'product_id' => $data['cart_product_id'],
                'product_image' => $data['cart_product_image'],
                'product_qty' => $data['cart_product_qty'],
                'product_price' => $data['cart_product_price'],

            );
            
        }
        Session::put('cart',$cart);
        Session::save();

    }
    public function del_product_cart($session_id){
        $cart = Session::get('cart');

        if($cart==true){
            foreach($cart as $key => $val){
                if($val['session_id']==$session_id){
                    unset($cart[$key]);
                }
            }
            Session::put('cart',$cart);
            return redirect()->back()->with('message','Xóa sản phẩm ra ngoài giỏ hàng');

        }else{
            return redirect()->back()->with('message','Xóa sản phẩm thất bại');
        }

    }
    
    public function update_cart(Request $request){
        $data = $request->all();
        $cart = Session::get('cart');
        if($cart==true){
            $message = '';
    
            foreach($data['cart_qty'] as $key => $qty){
                $i = 0;
                foreach($cart as $session => $val){
                    $i++;
    
                    if($val['session_id']==$key && $qty<$cart[$session]['product_quantity']){
    
                        $cart[$session]['product_qty'] = $qty;
                        $message.='<p style="color:blue">'.$i.') Cập nhật số lượng :'.$cart[$session]['product_name'].' thành công</p>';
    
                    }elseif($val['session_id']==$key && $qty>$cart[$session]['product_quantity']){
                        $message.='<p style="color:red">'.$i.') Cập nhật số lượng :'.$cart[$session]['product_name'].' thất bại</p>';
                    }
    
                }
    
            }
    
            Session::put('cart',$cart);
            return redirect()->back()->with('message',$message);
        }else{
            return redirect()->back()->with('message','Cập nhật số lượng thất bại');
        }
    }
    public function save_cart(Request $request){
               
         $cate_product = DB::table('tbl_category_product')->where('category_status','0')->orderby('category_id','desc')->get(); 
         $brand_product = DB::table('tbl_brand')->where('brand_status','0')->orderby('brand_id','desc')->get(); 
        
        $productID = $request->productid_hidden;
        $quantity = $request->qty;
        $product_info = DB::table('tbl_product')->where('product_id',$productID)->first(); 
        $data['id'] = $product_info->product_id;
        $data['qty'] = $quantity;
        $data['name'] = $product_info->product_name;
        $data['price'] = $product_info->product_price;
        $data['discount']=$product_info->product_discount;
        $data['weight'] = $product_info->product_price;
        $data['options']['image'] = $product_info->product_image;
        Cart::add($data);
        Cart::setGlobalTax(2);
        return view('pages.cart.show_cart')->with('category',$cate_product)->with('brand',$brand_product);
    }
    public function show_cart(Request $request){
   
       
    $cate_product = DB::table('tbl_category_product')->where('category_status','0')->orderby('category_id','desc')->get(); 
    $brand_product = DB::table('tbl_brand')->where('brand_status','0')->orderby('brand_id','desc')->get(); 
    return view('pages.cart.show_cart')->with('category',$cate_product)->with('brand',$brand_product);
}
public function delete_to_cart($rowId){
    Cart::update($rowId,0);
    return Redirect::to('/show-cart');
}
public function update_cart_quantity(Request $request){
    $rowId = $request->rowId_cart;
    $qty = $request->cart_quantity;
    Cart::update($rowId,$qty);
    return Redirect::to('/show-cart');
}

}
