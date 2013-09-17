package MT::Plugin::Template::OMV::XMLTransformer;
# XMLTransformer (C) 2013 Piroli YUKARINOMIYA (Open MagicVox.net)
# This program is distributed under the terms of the GNU Lesser General Public License, version 3.
# $Id: XMLTransformer.pl 305 2012-11-23 10:15:14Z pirolix $

use strict;
use warnings;
use MT 4;
use XML::LibXML;
use XML::LibXSLT;

use vars qw( $VENDOR $MYNAME $FULLNAME $VERSION );
$FULLNAME = join '::',
        (($VENDOR, $MYNAME) = (split /::/, __PACKAGE__)[-2, -1]);
(my $revision = '$Rev: 305 $') =~ s/\D//g;
$VERSION = 'v0.10'. ($revision ? ".$revision" : '');

use base qw( MT::Plugin );
my $plugin = __PACKAGE__->new ({
    id => $FULLNAME,
    key => $FULLNAME,
    name => $MYNAME,
    version => $VERSION,
    author_name => 'Open MagicVox.net',
    author_link => 'http://www.magicvox.net/',
    plugin_link => 'http://www.magicvox.net/archive/2013/09171148/', # Blog
    doc_link => "http://lab.magicvox.net/trac/mt-plugins/wiki/$MYNAME", # tracWiki
    description => <<"HTMLHEREDOC",
<__trans phrase="Supply template tags to transform a XML document with appling XSLT.">
XML::LibXML v@{[ $XML::LibXML::VERSION ]}, XML::LibXSLT v@{[ $XML::LibXSLT::VERSION ]}
HTMLHEREDOC
    l10n_class => "${FULLNAME}::L10N",
    registry => {
        tags => {
            help_url => "http://lab.magicvox.net/trac/mt-plugins/wiki/$MYNAME#tag-%t",
            block => {
                XMLTransform => "${FULLNAME}::Tags::XMLTransform",
                XMLApply => "${FULLNAME}::Tags::XMLTransform",
            },
        },
    },
});
MT->add_plugin ($plugin);

sub instance { $plugin; }

1;