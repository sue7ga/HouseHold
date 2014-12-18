package HouseHold::DB;
use strict;
use warnings;
use utf8;
use Data::Dumper;
use Date::Calc qw(Day_of_Week Week_Number Day_of_Week_to_Text);
use parent qw(Teng);

__PACKAGE__->load_plugin('Count');
__PACKAGE__->load_plugin('Replace');
__PACKAGE__->load_plugin('Pager');

sub insert_income{
 my($self,$param) = @_;
 $self->insert('income',$param);
}

sub insert_expense{
 my ($self,$param) = @_;
 $self->insert('expense',$param);
}

sub insert_user{
 my($self,$param) = @_;
 $self->insert('user',$param);
}

sub get_user_by_email{
 my($self,$email) = @_;
 my $user = $self->single('user',{email => $email});
 return $user;
}

sub get_income{
 my($self,$user_id,$date) = @_;
 my $itr = $self->search('income',+{user_id => $user_id,date => $date});
 return $itr;
}

sub get_total_income{
 my($self,$date) = @_;
 my $itr = $self->single('income',+{date => $date},+{columns => [qw/total/]});
 return $itr;
}

sub get_income_infos{
 my($self,$month,$week) = @_;
 my @incomes = $self->search('income',+{},+{});
 my $income_total = 0;
 my $extra_total = 0;
 my $business_total = 0;
 my $bonus_total = 0;
 my $other_total = 0;
 my $month_total = 0;
 my $wnum;
 for my $income(@incomes){
   my($dd,$mm,$yyyy) = ($income->date =~ /(\d+)\/(\d+)\/(\d+)/);
   if(not defined $dd || not defined $mm || not defined $yyyy){
         next;
   }
   $wnum = Week_Number($yyyy,$dd,$mm); 
   if(not defined $wnum){
       next;
   }
   unless($wnum%4  == $week%4){
       next;
   }
   unless($dd == $month){
       next;
   }
   $income_total += $income->income;
   $extra_total += $income->extra;
   $business_total += $income->business;
   $bonus_total += $income->bonus;
   $other_total += $income->other;
   $month_total += $income->total;
 }
 my $total_info = {};
 $total_info->{wnum} = $week;
 $total_info->{month} = $month;
 $total_info->{income_total} = $income_total;
 $total_info->{extra_total}  = $extra_total;
 $total_info->{business_total} = $business_total;
 $total_info->{bonus_total} = $bonus_total;
 $total_info->{other_total} = $other_total;
 $total_info->{month_total} = $month_total;
 return $total_info;
}

sub get_total_month{
 my($self,$num) = @_;
 my @incomes = $self->search('income',+{},+{});
 my $income_total = 0;
 my $extra_total = 0;
 my $business_total = 0;
 my $bonus_total = 0;
 my $other_total = 0;
 my $month_total = 0;
 for my $income(@incomes){
   my($dd,$mm,$yyyy) = ($income->date =~ /(\d+)\/(\d+)\/(\d+)/);
   unless($dd == $num){
          next;
   }
   $income_total += $income->income; 
   $extra_total += $income->extra; 
   $business_total += $income->business;
   $bonus_total += $income->bonus;
   $other_total += $income->other;
   $month_total += $income->total;
 }
 my $total_info = {income_total => $income_total,extra_total => $extra_total,business_total => $business_total,bonus_total => $bonus_total,other_total => $other_total,month_total => $month_total};
 return $total_info;
}

sub get_total_expense_month{
 my($self,$num) = @_;
 my @expenses = $self->search('expense',+{},+{});
 my $food_total = 0;
 my $good_total = 0;
 my $fare_total = 0;
 my $society_total = 0;
 my $entertainment_total = 0;
 my $teaching_total = 0;
 my $dress_total = 0;
 my $clinic_total = 0;
 my $communicate_total = 0;
 my $water_total = 0;
 my $living_total =0;
 my $car_total = 0;
 my $tax_total = 0;
 my $large_consume_total = 0;
 my $other_total = 0;
 my $month_total = 0;
  for my $exp(@expenses){
   my($dd,$mm,$yyyy) = ($exp->date =~ /(\d+)\/(\d+)\/(\d+)/);
   unless($dd == $num){
          next;
   }
   $food_total += $exp->food;  
   $good_total += $exp->good;
   $fare_total += $exp->fare;
   $society_total += $exp->society;
   $entertainment_total += $exp->entertainment;
   $teaching_total += $exp->teaching;
   $dress_total += $exp->dress;
   $clinic_total += $exp->clinic;
   $communicate_total += $exp->communicate;
   $water_total += $exp->water;
   $living_total += $exp->liveing;
   $car_total += $exp->car;
   $tax_total += $exp->tax;
   $large_consume_total += $exp->large_consume;
   $other_total += $exp->other;
   $month_total += $exp->total;
 }
 my $total_info = {};
 $total_info->{food_total} = $food_total;
 $total_info->{good_total} = $good_total;
 $total_info->{fare_total} = $fare_total;
 $total_info->{society_total} = $society_total;
 $total_info->{entertainment_total} = $entertainment_total;
 $total_info->{teaching_total} = $teaching_total;
 $total_info->{dress_total} = $dress_total;
 $total_info->{clinic_total} = $clinic_total;
 $total_info->{communicate_total} = $communicate_total;
 $total_info->{water_total} = $water_total;
 $total_info->{living_total} = $living_total;
 $total_info->{car_total} = $car_total;
 $total_info->{tax_total} = $tax_total;
 $total_info->{large_consume_total} = $large_consume_total;
 $total_info->{other_total} = $other_total;
 $total_info->{month_total} = $month_total;
 return $total_info;
}

sub get_expense{
 my($self,$user_id,$date) = @_;
 my $itr = $self->search('expense',+{user_id => $user_id,date => $date});
 return $itr;
}

sub user_change_pass{
 my($self,$user_id,$param) = @_; 
 my $itr = $self->search('user',+{id => $user_id});
 while(my $row = $itr->next){
   if($row->password eq $param->{password}){
    $self->update('user',+{password => $param->{newpassword}},+{id => $user_id});
   }
 }
}

1;
