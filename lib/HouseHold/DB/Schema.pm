package HouseHold::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'HouseHold::DB::Row';

table {
    name 'member';
    pk 'id';
    columns qw(id name);
};

table{
  name 'income';
  pk 'id';
  columns qw(id income extra business bonus advances_paid allowance pocket other user_id date total balance);
};

table{
 name 'user';
 pk 'id'; 
 columns qw(id email name password sex);
};

1;
