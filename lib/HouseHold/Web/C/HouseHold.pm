package HouseHold::Web::C::HouseHold;
use Data::Dumper;
use utf8;
use Encode;

#income
sub income{
 my($class,$c) = @_;
 if($c->session->get('userid')){
  return $c->render('income.tx');
 }else{
  return $c->redirect('/login');
 }
}

sub postincome{
 my($class,$c) = @_;
 $param = $c->req->parameters;
 my $total = 0;
 for (qw/income bonus extra business other/){
   $total += $param->{$_};
 }
 $param->add('total',$total);
 $param->add('user_id',$c->session->get('userid'));
 $param->remove('XSRF-TOKEN');
 $c->db->insert_income($param);
 return $c->redirect('/income');
}

sub expense{
 my($class,$c) = @_;
 if($c->session->get('userid')){
     return $c->render('expense.tx');
 }else{
    return $c->redirect('/login');
 }
}

sub settings{
 my($class,$c) = @_;
 if($c->session->get('userid')){
  return $c->render('settings.tx');
 }else{
  return $c->redirect('/login');
 }
}

sub post_expense{
 my($class,$c) = @_; 
 my $param = $c->req->parameters;
 my $total = 0;
 for (qw/food good fare society entertainment teaching dress clinic communicate water living car tax large_consume other/){
  $total += $param->{$_};
 }
 $param->add('total',$total);
 $param->add('user_id',$c->session->get('userid'));
 $param->remove('XSRF-TOKEN');
 $c->db->insert_expense($param);
 return $c->redirect('/expense/analytics');
}

sub expense_analytics{
 my ($class,$c) = @_;
 if($c->session->get('userid')){
  return $c->render('analytics_expense.tx');
}else{
  return $c->redirect('/login');
}
}

sub register{
 my($class,$c) = @_;
 return $c->render('register.tx');
}

sub userregister{
 my($class,$c) = @_;
 my $param = $c->req->parameters;
 $param->remove('XSRF-TOKEN');
 $param->remove('email_check');
 $param->remove('password_check');
 $c->db->insert_user($param);
return $c->redirect('/register');
}

sub login{
 my($class,$c) = @_;
 return $c->render('login.tx');
}

sub userlogin{
 my($class,$c) = @_;
 my $param = $c->req->parameters;
 my $user = $c->db->get_user_by_email($param->{email});
 if($param->{password} eq $user->password){
   $c->session->set('userid' => $user->id);
   return $c->redirect('/mypage'); 
 }else{
   return $c->redirect('/login');
 }
}

sub logout{
 my($class,$c) = @_;
 $c->session->remove('userid');
 return $c->redirect('/login');
}

sub mypage{
 my($class,$c) = @_;
 my $date = $c->session->get('date');
 my $itr = $c->db->get_total_income($date);
 if($c->session->get('userid')){ 
   return $c->render('mypage.tx',{total => $itr->total});
}else{
  return $c->redirect('/login');
}
}

sub month_income{
 my($class,$c) = @_;
 my $month_number = $c->session->get('month_number');
 my $total_info = $c->db->get_total_month($month_number);
 return $c->render('month_income.tx',{total_info => $total_info});
}

sub month_number{
 my($class,$c,$args) = @_;
 $c->session->set('month_number' => $args->{number});
 return $c->redirect('/month/income');
}

sub postanalytics{
 my($class,$c) = @_;
 $c->session->set('date' => $c->req->parameters->{date});
 return $c->redirect('/mypage');
}

sub expense_analytics{
 my($class,$c) = @_;
 if($c->session->get('userid')){
   return $c->render('analytics_expense.tx');
 }else{
  return $c->redirect('/login');
 }
}

sub post_expense_analytics{
 my($class,$c) = @_;
 $c->session->set('expense_date' => $c->req->parameters->{date});
 return $c->redirect('/expense/analytics');
}

sub change_password{
 my ($class,$c) = @_;
 my $param = $c->req->parameters;
 $c->db->user_change_pass($c->session->get('userid'),$param);
 return $c->redirect('/settings');
}

#json
sub income_month_info{
 my($class,$c) = @_;
 my $num = $c->session->get('month_number');
 my $total_info = $c->db->get_total_month($num);
 my $infos = [];
 push @$infos,$total_info;
 print Dumper $infos;
 return $c->render_json($infos);
}

sub analytics{
 my($class,$c) = @_;
 my $date = $c->session->get('date');
 my $itr = $c->db->get_income($c->session->get('userid'),$date);
 my $income = [];
 while(my $row = $itr->next){
     push @$income,{income => $row->income,extra => $row->extra,business=> $row->business,bonus => $row->bonus,total => $row->total};
 }
  $c->render_json($income);
}

sub analyticsexpense{
 my($class,$c) = @_;
 my $date = $c->session->get('expense_date');
 my $itr = $c->db->get_expense($c->session->get('userid'),$date);
 my $expense = [];
 while(my $row = $itr->next){
     push @$expense,{food => $row->food,good => $row->good,fare => $row->fare,society => $row->society,entertainment => $row->entertainment,teaching => $row->teaching, dress=> $row->dress,clinic => $row->clinic ,$communicate => $row->communicate,water => $row->water,living => $row->living,car => $row->car,tax => $row->tax,large_consume => $row->large_consume,other => $row->other};
 }
  $c->render_json($expense);
}

1;
