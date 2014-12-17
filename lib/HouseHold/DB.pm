package HouseHold::DB;
use strict;
use warnings;
use utf8;
use Data::Dumper;
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
 print Dumper $param;
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
