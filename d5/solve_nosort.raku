sub id-to-num(Str $id) {
        return :2($id.trans('F' => '0', 'B' => '1', 'L' => '0', 'R' => '1'));
}

my @ids = 'input'.IO.lines.map(&id-to-num);
my $range = @ids.minmax;

say 'part 1 ', $range.tail;

say 'part 2 ', $range.sum - @ids.sum;
