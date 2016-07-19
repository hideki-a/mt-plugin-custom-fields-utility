package CustomFieldsUtility::Tags;
use strict;

sub _hdlr_customfields_by_basename {
    my ( $ctx, $args, $cond ) = @_;
    my ($obj_type) = lc( $ctx->stash('tag') ) =~ m/(.*)customfieldsbybasename/;
    my $blog_id    = $ctx->stash('blog_id');
    my $builder    = $ctx->stash('builder');
    my $tokens     = $ctx->stash('tokens');

    if (!defined($args->{basename})) {
        return $ctx->error("Need customfield basename.");
    }

    require CustomFields::Field;
    my $terms = {
        obj_type => $obj_type,
        blog_id  => ( $blog_id ? [ $blog_id, 0 ] : 0 ),
        basename => $args->{basename}
    };
    my $field = CustomFields::Field->load($terms);

    local $ctx->{__stash}{field} = $field;
    defined( my $out = $builder->build( $ctx, $tokens ) )
        or return $ctx->error( $builder->errstr );

    $out;
}

1;
