package HouseHold::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

use Module::Find;

useall 'HouseHold::Web::C';
base 'HouseHold::Web::C';

get '/income' => "HouseHold#income";

post '/post/income' => "HouseHold#postincome";

get '/expense' => "HouseHold#expense";

post '/post/expense' => "HouseHold#postexpense";

get '/register' => "HouseHold#register";

post '/user/register' => "HouseHold#userregister";

get '/login' => "HouseHold#login";

post 'user/login' => "HouseHold#userlogin";

get '/mypage' => "HouseHold#mypage";

get '/analytics' => "HouseHold#analytics";

post '/post/analytics' => "HouseHold#postanalytics";

get '/expense/analytics' => "HouseHold#expense_analytics";


1;
