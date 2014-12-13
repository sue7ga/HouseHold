use File::Spec;
use File::Basename qw(dirname);
my $basedir = File::Spec->rel2abs(File::Spec->catdir(dirname(__FILE__), '..'));
my $dbpath = File::Spec->catfile($basedir, 'db', 'development.db');
+{
    'DBI' => [
        "dbi:mysql:household", 'suenaga', 'hirokihH5',
        +{
            mysql_enable_utf8 => 1
        },
    ],
   Auth => +{
    Twitter => +{
    consumer_key => 'I4sFcihDdmXT0Lf80nu3BD5Cq',
    consumer_secret => 'JAA2KmBKnuU7dOmqq4R9AJMYbIbJAgQmiOufD71lRtDopP2Xc8',
    ssl => 0,
    },
   },
  
};
