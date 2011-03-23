package Dist::Zilla::PluginBundle::IDOPEREL;

# ABSTRACT: IDOPEREL's plugin bundle for Dist::Zilla.

use Moose;
use namespace::autoclean;

with 'Dist::Zilla::Role::PluginBundle::Easy';

use version 0.77; our $VERSION = version->declare("v0.600.5");

use Dist::Zilla::PluginBundle::Filter;
use Dist::Zilla::PluginBundle::Classic;
use Dist::Zilla::PluginBundle::Git;
use Dist::Zilla::Plugin::VersionFromModule;
use Dist::Zilla::Plugin::MetaJSON;
use Dist::Zilla::Plugin::MinimumPerl;
use Dist::Zilla::Plugin::AutoPrereqs;
use Dist::Zilla::Plugin::Prereqs;
use Dist::Zilla::Plugin::NextRelease;
use Dist::Zilla::Plugin::GithubMeta;
use Dist::Zilla::Plugin::TestRelease;
use Dist::Zilla::Plugin::ReadmeFromPod;
use Dist::Zilla::Plugin::InstallGuide;
use Dist::Zilla::Plugin::CheckChangesHasContent;
use Dist::Zilla::Plugin::DistManifestTests;
use Dist::Zilla::Plugin::Signature;

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
	-remove = PkgVersion

	[@Git]
	tag_format = %v
	tag_message = %v

	[VersionFromModule]

	[AutoPrereqs]
	[Prereqs / ConfigureRequires]
	version = 0.77

	[CheckChangesHasContent]
	[DistManifestTests]
	[GithubMeta]
	[InstallGuide]
	[MetaJSON]
	[MinimumPerl]
	[NextRelease]
	[ReadmeFromPod]
	[TestRelease]
	[Signature]

=head1 INTERNAL METHODS

=head2 configure

=cut

sub configure {
	my $self = shift;

	$self->add_bundle(Filter => {
		-bundle => '@Classic',
		-remove => [qw/Readme PkgVersion/],
	});

	$self->add_bundle(Git => {
		tag_format => '%v',
		tag_message => '%v',
	});

	$self->add_plugins(
		'VersionFromModule',

		[ 'AutoPrereqs' => { skip => $self->payload->{auto_prereqs_skip} } ],
		[ 'Prereqs' => 'version' => { -phase => 'configure', -type => 'requires', 'version' => 0.77 } ],

		'CheckChangesHasContent',
		'DistManifestTests',
		'GithubMeta',
		'InstallGuide',
		'MetaJSON',
		'MinimumPerl',
		'NextRelease',
		'ReadmeFromPod',
		'TestRelease',
		'Signature'
	);
}

__PACKAGE__->meta->make_immutable;

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

=head1 LICENSE AND COPYRIGHT

Copyright 2010-2011 Ido Perlmuter.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1;
