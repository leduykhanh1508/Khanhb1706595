<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use Auth;
use Session;
use App\Slider;
use App\CatePost;
use App\Gallery;
use App\Comment;
use App\Product;
use App\Rating;
use File;
use Storage;
use App\Http\Requests;
use Illuminate\Support\Facades\Redirect;
session_start();
class ProductController extends Controller
{
    public function AuthLogin(){
        $admin_id = Session::get('admin_id');
        if($admin_id){
            return Redirect::to('dashboard');
        }else{
            return Redirect::to('admin')->send();
        }   
    }
    
       
   public function file_browser(Request $request){
        $paths = glob(public_path('uploads/ckeditor/*'));

        $fileNames = array();

        foreach($paths as $path){
            array_push($fileNames,basename($path));
        }
        $data = array(
            'fileNames' => $fileNames
        );
       
        return view('admin.images.file_browser')->with($data);
   }
   
  
   
    public function local_storage(){
         return view('pages.local_storage.storage');
    }

    public function quickview(Request $request){

        $product_id = $request->product_id;
        $product = Product::find($product_id);

        $gallery = Gallery::where('product_id',$product_id)->get();

        $output['product_gallery'] = '';
        
        foreach($gallery as $key => $gal){
            $output['product_gallery'].= '<p><img width="100%" src="public/uploads/gallery/'.$gal->gallery_image.'"></p>';
        }

        $output['product_name'] = $product->product_name;
        $output['product_id'] = $product->product_id;
        $output['product_desc'] = $product->product_desc;
        $output['product_content'] = $product->product_content;
        $output['product_price'] = number_format($product->product_price,0,',','.').'VNĐ';
        $output['product_image'] = '<p><img width="100%" src="public/uploads/product/'.$product->product_image.'"></p>';

        $output['product_button'] = '<input type="button" value="Mua ngay" class="btn btn-primary btn-sm add-to-cart-quickview" id="buy_quickview" data-id_product="'.$product->product_id.'"  name="add-to-cart">';

        $output['product_quickview_value'] = '

        <input type="hidden" value="'.$product->product_id.'" class="cart_product_id_'.$product->product_id.'">
                                            
        <input type="hidden" value="'.$product->product_name.'" class="cart_product_name_'.$product->product_id.'">
                                          
        <input type="hidden" value="'.$product->product_quantity.'" class="cart_product_quantity_'.$product->product_id.'">
                                            
        <input type="hidden" value="'.$product->product_image.'" class="cart_product_image_'.$product->product_id.'">

        <input type="hidden" value="'.$product->product_price.'" class="cart_product_price_'.$product->product_id.'">

        <input type="hidden" value="1" class="cart_product_qty_'.$product->product_id.'">';

        echo json_encode($output);
       

    }

    public function add_product(){
     
        $cate_product = DB::table('tbl_category_product')->orderby('category_id','desc')->get(); 
        $brand_product = DB::table('tbl_brand')->orderby('brand_id','desc')->get(); 
       
        return view('admin.add_product')->with('cate_product', $cate_product)->with('brand_product',$brand_product);
    	

    }
    public function all_product(){
    
    	$all_product = DB::table('tbl_product')
        ->join('tbl_category_product','tbl_category_product.category_id','=','tbl_product.category_id')
        ->join('tbl_brand','tbl_brand.brand_id','=','tbl_product.brand_id')
        ->orderby('tbl_product.product_id','desc')->get();
    	$manager_product  = view('admin.all_product')->with('all_product',$all_product);
    	return view('admin_layout')->with('admin.all_product', $manager_product);

    }
    public function save_product(Request $request){
    	$data = array();
    	$data['product_name'] = $request->product_name;
        $data['product_price'] =$request->product_price;
    	$data['product_desc'] = $request->product_desc;
        $data['product_quantity'] = $request->product_quantity;
        $data['product_content'] = $request->product_content;
        $data['category_id'] = $request->product_cate;
        $data['brand_id'] = $request->product_brand;
        $data['product_status'] = $request->product_status;
        $data['product_image'] = $request->product_status;
        $get_image = $request->file('product_image');
        $path = 'public/uploads/product/';
        //them hinh anh
        if($get_image){
            $get_name_image = $get_image->getClientOriginalName();
            $name_image = current(explode('.',$get_name_image));
            $new_image =$name_image.rand(0,99).'.'.$get_image->getClientOriginalExtension();
            $get_image->move($path,$new_image);
            $data['product_image'] = $new_image;
            DB::table('tbl_product')->insert($data);
            Session::put('message','Thêm sản phẩm thành công');
            return Redirect::to('add-product');     
        }
        $data['product_image']='';
        DB::table('tbl_product')->insert($data);
        Session::put('message','Thêm sản phẩm thành công');
        return Redirect::to('add-product');
    }
    public function inactive_product($product_id){
        
        DB::table('tbl_product')->where('product_id',$product_id)->update(['product_status'=>1]);
        Session::put('message','Đã ẩn danh mục');
        return Redirect::to('all-product');

    }
    public function active_product($product_id){
      
        DB::table('tbl_product')->where('product_id',$product_id)->update(['product_status'=>0]);
        Session::put('message','Kích hoạt sản phẩm thành công');
        return Redirect::to('all-product');
    }
    public function edit_product($product_id){
      
       $cate_product = DB::table('tbl_category_product')->orderby('category_id','desc')->get(); 
       $brand_product = DB::table('tbl_brand')->orderby('brand_id','desc')->get(); 

        $edit_product = DB::table('tbl_product')->where('product_id',$product_id)->get();

        $manager_product  = view('admin.edit_product')->with('edit_product',$edit_product)->with('cate_product',$cate_product)->with('brand_product',$brand_product);

        return view('admin_layout')->with('admin.edit_product', $manager_product);
    }
    public function update_product(Request $request,$product_id){
        $data = array();
        $data['product_name'] = $request->product_name;
        $data['product_price'] =$request->product_price;
        $data['product_desc'] = $request->product_desc;
        $data['product_content'] = $request->product_content;
        $data['category_id'] = $request->product_cate;
        $data['brand_id'] = $request->product_brand;
        $data['product_status'] = $request->product_status;

        $get_image = $request->file('product_image');
        $get_document = $request->file('document');

        $path_document = 'public/uploads/document/';

        if($get_image){
                    $get_name_image = $get_image->getClientOriginalName();
                    $name_image = current(explode('.',$get_name_image));
                    $new_image =  $name_image.rand(0,99).'.'.$get_image->getClientOriginalExtension();
                    $get_image->move('public/uploads/product',$new_image);
                    $data['product_image'] = $new_image;
                    DB::table('tbl_product')->where('product_id',$product_id)->update($data);
                    Session::put('message','Cập nhật sản phẩm thành công');
                    return Redirect::to('all-product');
        }
          
        DB::table('tbl_product')->where('product_id',$product_id)->update($data);
        Session::put('message','Cập nhật sản phẩm thành công');
        return Redirect::to('all-product');
    }
    public function delete_document(Request $request){
        //lay file old document 
        $path_document = 'public/uploads/document/';
        $product = Product::find($request->product_id);
        unlink($path_document.$product->product_file);
        $product->product_file = '';
        $product->save();
        
    }
    public function delete_product($product_id){
        DB::table('tbl_product')->where('product_id',$product_id)->delete();
        Session::put('message','Xóa sản phẩm thành công');
        return Redirect::to('all-product');
    }
    //End Admin Page
    public function details_product($product_id){
        $cate_product = DB::table('tbl_category_product')->where('category_status','0')->orderby('category_id','desc')->get(); 

        $brand_product = DB::table('tbl_brand')->where('brand_status','0')->orderby('brand_id','desc')->get(); 

        $details_product = DB::table('tbl_product')
        ->join('tbl_category_product','tbl_category_product.category_id','=','tbl_product.category_id')
        ->join('tbl_brand','tbl_brand.brand_id','=','tbl_product.brand_id')
        ->where('tbl_product.product_id',$product_id)->get();
        foreach($details_product as $key => $value){
            $category_id = $value->category_id;
        }
        $related_product = DB::table('tbl_product')
        ->join('tbl_category_product','tbl_category_product.category_id','=','tbl_product.category_id')
        ->join('tbl_brand','tbl_brand.brand_id','=','tbl_product.brand_id')
        ->where('tbl_category_product.category_id',$category_id)->whereNotIn('tbl_product.product_id',[$product_id])->get();
        return view('pages.product.show_details')->with('category',$cate_product)->with('brand',$brand_product)->with('product_details',$details_product)->with('relate', $related_product);

    }
    public function tag(Request $request, $product_tag){
        
         //category post
        $category_post = CatePost::orderBy('cate_post_id','DESC')->get();
         //slide
        $slider = Slider::orderBy('slider_id','DESC')->where('slider_status','1')->take(4)->get();

        $cate_product = DB::table('tbl_category_product')->where('category_status','0')->orderby('category_id','desc')->get(); 
        $brand_product = DB::table('tbl_brand')->where('brand_status','0')->orderby('brand_id','desc')->get(); 


        $tag = str_replace("-"," ",$product_tag);


        
        $pro_tag = Product::where('product_status',0)->where('product_name','LIKE','%'.$tag.'%')->orWhere('product_tags','LIKE','%'.$tag.'%')->orWhere('product_slug','LIKE','%'.$tag.'%')->get();



        $meta_desc = 'Tags tìm kiếm::'.$product_tag;
        $meta_keywords = 'Tags tìm kiếm:'.$product_tag;
        $meta_title = 'Tags tìm kiếm:'.$product_tag;
        $url_canonical = $request->url();
        

      
        return view('pages.sanpham.tag')->with('slider',$slider)->with('category_post',$category_post)->with('category',$cate_product)->with('brand',$brand_product)->with('meta_desc',$meta_desc)->with('meta_keywords',$meta_keywords)->with('meta_title',$meta_title)->with('url_canonical',$url_canonical)->with('product_tag',$product_tag)->with('pro_tag',$pro_tag);

    }
    public function insert_rating(Request $request){
        $data = $request->all();
        $rating = new Rating();
        $rating->product_id = $data['product_id'];
        $rating->rating = $data['index'];
        $rating->save();
        echo 'done';
    }

    public function ckeditor_image(Request $request){
       if($request->hasFile('upload')) {

            $originName = $request->file('upload')->getClientOriginalName();
            $fileName = pathinfo($originName, PATHINFO_FILENAME);
            $extension = $request->file('upload')->getClientOriginalExtension();
            $fileName = $fileName.'_'.time().'.'.$extension;
            $request->file('upload')->move('public/uploads/ckeditor', $fileName);
   
            $CKEditorFuncNum = $request->input('CKEditorFuncNum');
            $url = asset('public/uploads/ckeditor/'.$fileName); 
            $msg = 'Tải ảnh thành công'; 
            $response = "<script>window.parent.CKEDITOR.tools.callFunction($CKEditorFuncNum, '$url', '$msg')</script>";
            @header('Content-type: text/html; charset=utf-8'); 
            echo $response;

        }
    }
   
}
