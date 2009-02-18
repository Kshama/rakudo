## $Id$

=head1 NAME

src/classes/Pair.pir - methods for the Pair class

=head1 Methods

=over 4

=cut

.namespace ['Perl6Pair']

.sub 'onload' :anon :load :init
    .local pmc p6meta, pairproto
    p6meta = get_hll_global ['Perl6Object'], '$!P6META'
    pairproto = p6meta.'new_class'('Perl6Pair', 'parent'=>'Any', 'attr'=>'$!key $!value', 'name'=>'Pair')
    pairproto.'!IMMUTABLE'()
.end


=item ACCEPTS()

Called from smartmatches '$_ ~~ X'.
Delegates on to a method call '.:Xkey(Xval)'.

=cut

.sub 'ACCEPTS' :method
    .param pmc topic

    $S0 = self.'key'()
    $S0 = concat ':', $S0

    $P0 = self.'value'()

    .tailcall topic.$S0($P0)
.end


=item get_string()  (vtable method)

Stringify the Pair.

=cut

.sub 'get_string' :method :vtable
    $S0 = self.'key'()
    concat $S0, "\t"
    $S1 = self.'value'()
    concat $S0, $S1
    .return ($S0)
.end


=item fmt

 our Str multi Pair::fmt ( Str $format )

Returns the invocant pair formatted by an implicit call to C<sprintf> on
the key and value.

=cut

.sub 'fmt' :method
    .param pmc format

    .local pmc retv
    .local pmc key
    .local pmc value

    key = self.'key'()
    value = self.'value'()
    retv = 'sprintf'(format, key, value)

    .return(retv)
.end


.namespace []

.sub 'infix:=>'
    .param pmc key
    .param pmc value
    key = key.'item'()
    value = value.'item'()
    $P0 = new ['Perl6Pair']
    $P1 = new ['Perl6Scalar']
    'infix:='($P1, key)
    setattribute $P0, '$!key', $P1
    setattribute $P0, '$!value', value
    .return ($P0)
.end


.sub 'infix:cmp' :multi(['Perl6Pair'], ['Perl6Pair'])
    .param pmc a
    .param pmc b
    $P0 = a.'key'()
    $P1 = b.'key'()
    $I0 = 'infix:cmp'($P0, $P1)
    unless $I0 == 0 goto done
    $P0 = a.'value'()
    $P1 = b.'value'()
    $I0 = 'infix:cmp'($P0, $P1)
  done:
    $P0 = 'infix:<=>'($I0, 0)
    .return ($P0)
.end


=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
