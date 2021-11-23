<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use App\Http\Requests;
use Session;
use Illuminate\Support\Facades\Redirect;
use App\Login;
session_start();

class Admincontroller extends Controller
{
    public function AuthLogin(){
        $admin_id = Session::get('admin_id');
        if($admin_id){
            return Redirect::to('dashboard');
        }else{
            return Redirect::to('admin')->send();
        }   
    }

    public function index(){
        return view('admin_login');
    }
    public function show_dashboard(){
        $this->AuthLogin();
        return view('admin.dashboard');
    }
   
    public function dashboard(Request $request){
        $admin_email = $request->admin_email;
        $admin_password = md5($request->admin_password);

        $login = Login::where('admin_email',$admin_email)->where('admin_password',$admin_password)->first();
        if($login){
            $login_count = $login->count();
            if($login_count>0){
                Session::put('admin_name',$login->admin_name);
                Session::put('admin_id',$login->id);
                return Redirect::to('/dashboard');
            }
        }else{
                Session::put('message','Tài khoản hoặc mật khẩu sai!Vui lòng nhập lại.');
                return Redirect::to('/admin');
        }
    }
    public function logout(){
            $this->AuthLogin();
            Session::put('admin_name',null);
            Session::put('admin_id',null);
            return Redirect::to('/admin');
        
        }
}
