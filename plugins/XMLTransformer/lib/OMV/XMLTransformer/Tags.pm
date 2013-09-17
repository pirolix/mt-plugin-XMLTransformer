package OMV::XMLTransformer::Tags;
# $Id: Tags.pm 345 2013-07-21 07:12:00Z pirolix $

use strict;
use warnings;
use MT;
use XML::LibXML;
use XML::LibXSLT;

use vars qw( $VENDOR $MYNAME $FULLNAME );
$FULLNAME = join '::',
        (($VENDOR, $MYNAME) = (split /::/, __PACKAGE__)[0, 1]);

sub instance { MT->component($FULLNAME); }



### mt:XMLTransform block tag
sub XMLTransform {
    my ($ctx, $args, $cond) = @_;

    my $doc = $args->{doc} || $args->{data};
    my $style = $args->{style} || $args->{xslt};

    !defined $doc && !defined $style
        and return $ctx->error (&instance->translate ("You must need the either parameter for document or style at least."));

    # When specifing the single paramater,
    unless (defined $doc && defined $style) {
        # consider the inner contents
        my $builder = $ctx->stash ('builder');
        my $tokens = $ctx->stash ('tokens');
        defined (my $out = $builder->build ($ctx, $tokens, $cond))
            or return $ctx->error ($builder->errstr);
        # as the leavings parameter
        defined $doc
            ? ($style = $out)
            : ($doc = $out);
    }
    $doc =~ s/^\s+//;
    $style =~ s/^\s+//;

    # Parse XML document
    my $err;
    my $xml_parser = XML::LibXML->new
        or return $ctx->error (&instance->translate ("Failed to initialize XML::LibXML"));
    my $doc_xml = eval { $xml_parser->parse_string ($doc) };
    ($err = $@)
        and return $ctx->error (&instance->translate ("Failed to parse the document as XML document. [_1]", $err));
    my $doc_xsl = eval { $xml_parser->parse_string ($style) };
    ($err = $@)
        and return $ctx->error (&instance->translate ("Failed to parse the style as XML document. [_1]", $err));
    # Do transform XML with XSLT
    my $xslt = XML::LibXSLT->new
        or return $ctx->error (&instance->translate ("Failed to initialize XML::LibXSLT"));
    my $xsl_obj = $xslt->parse_stylesheet ($doc_xsl)
        or return $ctx->error (&instance->translate ("XSLT can't get stylesheet"));
    my $results = $xsl_obj->transform ($doc_xml)
        or return $ctx->error (&instance->translate ("XSLT can't transform XML document"));

    return Encode::decode (MT->config->PublishCharset, $xsl_obj->output_string ($results));
}

1;