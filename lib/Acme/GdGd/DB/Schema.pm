package Acme::GdGd::DB::Schema;
use Teng::Schema::Declare;
use DateTime::Format::MySQL;

table {
    name 'User';
    columns qw( user key create_at );

    inflate 'create_at' => sub {
        DateTime::Format::MySQL->parse_datetime(shift);
    };
    deflate 'create_at' => sub {
        DateTime::Format::MySQL->format_datetime(shift);
    };
};

table {
    name 'Hook';
    columns qw( user event issued_at);

    inflate 'issued_at' => sub {
        DateTime::Format::MySQL->parse_datetime(shift);
    };
    deflate 'issued_at' => sub {
        DateTime::Format::MySQL->format_datetime(shift);
    };

};

1;
