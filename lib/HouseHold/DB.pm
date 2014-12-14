package HouseHold::DB;
use strict;
use warnings;
use utf8;
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

sub get_expense{
 my($self,$user_id,$date) = @_;
 my $itr = $self->search('expense',+{user_id => $user_id,date => $date});
 return $itr;
}

1;
