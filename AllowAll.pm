package HTML::EscapeEvil::AllowAll;

use strict;
use base qw(HTML::EscapeEvil);
use File::Basename;
use File::Spec;
use YAML;
use constant ALLOWTAGS_YAML => "AllowTagsDetails.yaml";

our($ALLOW_YAML_PATH,$VERSION);
BEGIN{

	$VERSION = 0.01;

# set yaml path
	my $pkgpm = __PACKAGE__;
	$pkgpm =~ s/::/\//g;
	$pkgpm .= ".pm";
	$ALLOW_YAML_PATH = File::Spec->catfile(dirname($INC{$pkgpm}),"AllowAll",ALLOWTAGS_YAML);
}

sub new{

	my $class = shift;
	my $self = $class->SUPER::new;
	bless $self,ref $class || $class;
	$self->allow_all;
	$self;
}

sub allow_all{

	my $self = shift;
	$self->allow_comment(1);
	$self->allow_declaration(1);
	$self->allow_process(1);
	$self->allow_entity_reference(1);
	$self->collection_process(1);

	$self->add_allow_tags(&_read_yaml);
}

# read all tags yaml
sub _read_yaml{

	map { @{(each %{$_})[1]} } @{YAML::LoadFile($ALLOW_YAML_PATH)};
}


1;

__END__

=head1 NAME

HTML::EscapeEvil::AllowAll - Escape tag.but all tag allow

=head1 VERSION

0.01

=head1 SYNPSIS

    use HTML::EscapeEvil::AllowAll;
    my $escapeallow = HTML::EscapeEvil::AllowAll->new;
    print "script is " , ($escapeallow->allow_script) ? "allow" : "not allow";
    print "style is " , ($escapeallow->allow_style) ? "allow" : "not allow";
    $escapeallow->clear;

=head1 DESCRIPTION

Only tag where it wants to escape is specified with deny_tags method etc. 

and it uses it because it all enters the state of permission. 

=head1 METHOD

=head2 new

Create instance & all tags allow.

=head2 allow_all

All tags allow.

Example : 

    $escapeallow->allow_all;

=head1 SEE ALSO

L<File::Basename> L<File::Spec> L<HTML::EscapeEvil> L<YAML>

=head1 AUTHOR

Akira Horimoto <kurt0027@gmail.com>

=head1 COPYRIGHT

Copyright (C) 2006 Akira Horimoto

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

