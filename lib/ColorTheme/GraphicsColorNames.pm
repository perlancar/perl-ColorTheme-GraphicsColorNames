package ColorTheme::GraphicsColorNames;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict 'subs', 'vars';
use warnings;
use parent 'ColorThemeBase::Base';

our %THEME = (
    v => 2,
    summary => 'Display Graphics::ColorNames::* color scheme as color theme',
    dynamic => 1,
    args => {
        scheme => {
            schema => 'perl::modname_with_args*',
            req => 1,
            pos => 0,
        },
    },
);

sub new {
    my $class = shift;
    my %args = @_;

    my $self = $class->SUPER::new(%args);

    require Module::Load::Util;

    my $res = Module::Load::Util::load_module_with_optional_args(
        {ns_prefix=>'Graphics::ColorNames'}, $self->{args}{scheme});

    $self->{table} = &{"$res->{module}::NamesRgbTable"}();
    $self;
}

sub list_items {
    my $self = shift;

    my @list = sort keys %{ $self->{table} };
    wantarray ? @list : \@list;
}

sub get_item_color {
    my ($self, $name, $args) = @_;
    sprintf "%06x", $self->{table}{$name};
}

1;
# ABSTRACT:

=head1 SEE ALSO

Other C<ColorTheme::*> modules.
