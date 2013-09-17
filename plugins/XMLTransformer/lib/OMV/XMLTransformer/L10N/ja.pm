package OMV::XMLTransformer::L10N::ja;
# $Id: ja.pm 346 2013-07-21 07:59:10Z pirolix $

use strict;
use base 'OMV::XMLTransformer::L10N';
use vars qw( %Lexicon );

%Lexicon = (
    # *.pl
    'Supply template tags to transform a XML document with appling XSLT.' => 'XSLT を適用して XML 文書を変換するテンプレート タグを提供します。',
    # Tags.pm
    "You must need the either parameter for document or style at least." => 'document または style のうち少なくとも 1 つのパラメータが必要です。',
    "Failed to initialize XML::LibXML" => 'XML::LibXML の初期化に失敗しました。',
    "Failed to parse the document as XML document. [_1]" => 'document を XML 文書として処理できませんでした。[_1]',
    "Failed to parse the style as XML document. [_1]" => 'style を XML 文書として処理できませんでした。[_1]',
    "Failed to initialize XML::LibXSLT" => 'XML::LibXSLT の初期化に失敗しました。',
    "XSLT can't get stylesheet" => 'XSLT はスタイルシートを取得できません。',
    "XSLT can't transform XML document" => 'XSLT は XML 文書の変換ができません。',
);

1;