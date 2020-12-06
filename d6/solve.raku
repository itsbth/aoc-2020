my @groups = 'input'.IO.slurp.split("\n\n")>>.split("\n")>>.grep(*.chars > 0)>>.map(*.comb)>>.map(&set);
# Need to comment out one of the parts to run the other, as any attempts to cache the seqs or convert them to an array somehow results in the wrong answer.
say 'part 1 ', @groups.map({ ([(|)] $^g) }).sum;
say 'part 2 ', @groups.map({ ([(&)] $^g) }).sum;
