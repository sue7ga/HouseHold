package HouseHold::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

use Module::Find;

useall 'HouseHold::Web::C';
base 'HouseHold::Web::C';

#income
get '/income' => "HouseHold#income";

post '/post/income' => "HouseHold#postincome";

get '/mypage' => "HouseHold#mypage";

get '/month/income' => "HouseHold#month_income";

get '/analytics' => "HouseHold#analytics";

post '/post/analytics' => "HouseHold#postanalytics";

get 'month/:number' => "HouseHold#month_number";

get '/income/month/info' => "HouseHold#income_month_info";
#expense

get '/expense' => "HouseHold#expense";

post '/post/expense' => "HouseHold#post_expense";

get '/expense/analytics' => "HouseHold#expense_analytics";

post '/post/expense/analytics' => "HouseHold#post_expense_analytics";

get 'analytics/expense' => "HouseHold#analyticsexpense";

#user

get '/register' => "HouseHold#register";

post '/user/register' => "HouseHold#userregister";

get '/login' => "HouseHold#login";

post 'user/login' => "HouseHold#userlogin";

get 'logout' => "HouseHold#logout";

get '/settings' => "HouseHold#settings";

post 'setting/password' => "HouseHold#change_password";

1;
