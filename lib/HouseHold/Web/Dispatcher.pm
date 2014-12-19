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

get '/income/week/info' => "HouseHold#income_week_info";

get '/income/:number' => "HouseHold#week";

get '/week/income' => "HouseHold#week_analytics";


#expenses

#month
get '/expense/months/:num' => "HouseHold#month_expense";
#week
get '/expense/:num' => "HouseHold#expense_week_in_month";

get '/expense/month/info' => "HouseHold#month_info";

get '/expense/month/infos' => "HouseHold#expense_month_info";

get '/expense/month' => "HouseHold#month_expense";

get '/expense' => "HouseHold#expense";

get '/day/expense' => "HouseHold#expense_day";

get 'month/expense/:num' => "HouseHold#month_expense_analytics";

post 'post/expense/day' => "HouseHold#post_expense_day";

post '/post/expense' => "HouseHold#post_expense";

get '/expense/analytics' => "HouseHold#expense_analytics";

post '/post/expense/analytics' => "HouseHold#post_expense_analytics";

get 'analytics/expense' => "HouseHold#analyticsexpense";

get 'analytics/expense/week' => "HouseHold#expense_week_in_month";

get '/expense/month/only/:num' => "HouseHold#month_expense_analytics";

get '/analytics/ex/json' => "HouseHold#ex_week_json";

get '/analytics/ex/day/json' => "HouseHold#day_ex_json";

get '/month/only/json' => "HouseHold#month_only";
#user

get '/register' => "HouseHold#register";

post '/user/register' => "HouseHold#userregister";

get '/login' => "HouseHold#login";

post 'user/login' => "HouseHold#userlogin";

get 'logout' => "HouseHold#logout";

get '/settings' => "HouseHold#settings";

post 'setting/password' => "HouseHold#change_password";

1;
