package Dist::Zilla::PluginBundle::IDOPEREL;

use Moose;
use Moose::Autobox;
use namespace::autoclean;
with 'Dist::Zilla::Role::PluginBundle';

# ABSTRACT: IDOPEREL's plugin bundle for Dist::Zilla.

use Dist::Zilla::PluginBundle::Filter;
use Dist::Zilla::PluginBundle::Classic;
use Dist::Zilla::PluginBundle::Git;
use Dist::Zilla::Plugin::MetaJSON;
use Dist::Zilla::Plugin::MinimumPerl;
use Dist::Zilla::Plugin::AutoPrereq;
use Dist::Zilla::Plugin::NextRelease;
use Dist::Zilla::Plugin::GithubMeta;
use Dist::Zilla::Plugin::TestRelease;
use Dist::Zilla::Plugin::ReadmeFromPod;

sub bundle_config {
	my ($self, $section) = @_;
	my $class = ref($self) || $self;

	my $arg = $section->{payload};

	my @plugins = Dist::Zilla::PluginBundle::Filter->bundle_config(
		{
			name    => "$class/Classic",
			payload => {
				bundle => '@Classic',
				remove => [qw/Readme/],
			}
		}
	);

	# params for AutoVersion
	my $major_version = defined $arg->{major_version} ? $arg->{major_version} : 1;

	# params

	my $prefix = 'Dist::Zilla::Plugin::';
	my @extra = map { [ "$class/$prefix$_->[0]" => "$prefix$_->[0]" => $_->[1] ] } (
		[ AutoPrereq          => { skip  => $arg->{auto_prereq_skip} } ],
		[ AutoVersion         => { major => $major_version } ],
		[ CheckChangeLog      => {} ],
		[ CheckChangesTests   => {} ],
		[ CompileTests        => {} ],
		[ HasVersionTests     => {} ],
		[ MetaTests           => {} ],
		[ MetaJSON            => {} ],
		[ ManifestSkip        => {} ],
		[ MetaResources       => \%meta_resources ],
		[ MinimumVersionTests => {} ],
		[ ModuleBuild         => {} ],
		[ NextRelease         => {} ],
		[ PodWeaver           => {} ],
		[ PortabilityTests    => {} ],
		[ Prepender           => {} ],
		[ ReadmeFromPod       => {} ],
		[ Manifest            => {} ],   # should come last
	);

	push (@plugins, @extra);

	# add git plugins
	push (@plugins,	Dist::Zilla::PluginBundle::Git->bundle_config({ name => "$section->{name}/Git",	payload => {} });

	eval "require $_->[1]; 1;" or die for @plugins; ## no critic Carp

	return @plugins;
}

__PACKAGE__->meta->make_immutable;

=head1 NAME

Dist::Zilla::PluginBundle::IDOPEREL - IDOPEREL's plugin bundle for Dist::Zilla.

=head1 SYNOPSIS

In your dist.ini file:

	[@IDOPEREL]

=head1 DESCRIPTION

This module is a bundle of plugins for L<Dist::Zilla> that is regularly
used by me (Ido Perlmuter). If you find it suits your needs, feel free
to install and use it.

This bundle provides the following plugins and bundles:

	[@Filter]
	-bundle = @Classic
	-remove = Readme

	[GatherDir]
	[PruneCruft]
	[ManifestSkip]
	[MetaYAML]
	[MetaJSON]
	[License]
	[PkgVersion]
	[PodVersion]
	[PodCoverageTests]
	[PodSyntaxTests]
	[ExtraTests]
	[ExecDir]
	[ShareDir]
	[MakeMaker]
	[MinimumPerl]
	[Manifest]
	[ConfirmRelease]
	[UploadToCPAN]
	[AutoPrereq]
	[@Git]
	[NextRelease]
	[GithubMeta]
	[ReadmeFromPod]
	[TestRelease]

=head1 AUTHOR

Ido Perlmuter, C<< <ido at ido50.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-dist-zilla-pluginbundle-idoperel at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Dist-Zilla-PluginBundle-IDOPEREL>. I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

	perldoc Dist::Zilla::PluginBundle::IDOPEREL

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Dist-Zilla-PluginBundle-IDOPEREL>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Dist-Zilla-PluginBundle-IDOPEREL>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Dist-Zilla-PluginBundle-IDOPEREL>

=item * Search CPAN

L<http://search.cpan.org/dist/Dist-Zilla-PluginBundle-IDOPEREL/>

=back

=head1 ACKNOWLEDGMENTS

Based on L<Dist::Zilla::PluginBundle::PDONELAN> by Patrick Donelan.

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Ido Perlmuter.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1;
