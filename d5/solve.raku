sub id-to-num(Str $id) {
        return :2($id.trans('F' => '0', 'B' => '1', 'L' => '0', 'R' => '1'));
}

my @ids = 'input'.IO.lines.map(&id-to-num).sort;

say 'part 1 ', @ids.tail;

say 'part 2 ', (@ids.first .. @ids.tail) (-) @ids;
