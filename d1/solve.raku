my @input = 'input'.IO.slurp.lines>>.Int;

say 'Part 1: ', [*] @input.combinations(2).grep(*.sum == 2020).first;
say 'Part 2: ', [*] @input.combinations(3).grep(*.sum == 2020).first;
