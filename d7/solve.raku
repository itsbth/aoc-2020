grammar BagRules {
    token TOP { <RULE>+ % "\n" "\n"? }
    token RULE {
        <BAG> " contain " <BAGLIST> "."
    }
    token BAG {
        $<COL> = [\w+ " " \w+] " bag" "s"?
    }
    token BAGLIST {
        [$<N> = \d+ " " <BAG>]+ % ", " | "no other bags"
    }
}

class BagRules-Actions {
    method TOP($/) {
        my @rules = $<RULE>.map(*.made);
        make hash @rules;
    }
    method RULE($/) {
        make $<BAG>.made => $<BAGLIST>.made;
    }
    method BAG($/) {
        make $<COL>.Str;
    }
    method BAGLIST($/) {
        if $/.Str eq 'no other bags' {
            make Hash.new
        } else {
            make Hash.new: ($<BAG> Z $<N>).map(-> ($b, $n) { $b.made => $n.Int });
        }
    }
}

my %rules = BagRules.parse('input'.IO.slurp.trim, actions => BagRules-Actions.new).made;
(my %can-be-contained-in).push: %rules.kv.map({ $^a => $^b.keys }).Map.invert;

 my $open = SetHash.new('shiny gold');
 my $closed = SetHash.new();

 while ($open) {
         my $bag = $open.grab.head;
         $closed.set($bag);
         next unless %can-be-contained-in{$bag}:exists;
         for %can-be-contained-in{$bag}.Array -> $cont {
                 $open.set($cont) unless $cont (elem) $closed;
         }

 }
say 'part 1 ', $closed - 1;

sub cost-of-filling($bag) {
    my $total = 1;
    for %rules{$bag}.kv -> $k, $v {
        #say "$($bag) → $($k) × $($v)";
        $total += cost-of-filling($k) * $v;
    }
    return $total;
}

say 'part 2 ', cost-of-filling('shiny gold') - 1;