package HouseHold::Web::C::HouseHold;
use Data::Dumper;
use utf8;
use Encode;

sub income{
 my($class,$c) = @_;
 return $c->render('income.tx');
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
 print Dumper $param;
 $c->db->insert_income($param);
 return $c->redirect('/income');
}

sub expense{
 my($class,$c) = @_;
 return $c->render('expense.tx');
}

sub postexpense{
 my($class,$c) = @_;
 print Dumper $c->req->parameters;
 return $c->redirect('/expense');
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
 }
 return $c->redirect('login.tx');
}

sub mypage{
 my($class,$c) = @_;
 return $c->render('mypage.tx');
}

sub postanalytics{
 my($class,$c) = @_;
 $c->session->set('date' => $c->req->parameters->{date});
 return $c->redirect('/mypage');
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

1;
