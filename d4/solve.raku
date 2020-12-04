grammar PPB {
	token TOP { ^ <RECORD>+ % "\n\n" "\n"? $ }
	token RECORD { <PAIR>+ % (' ' | "\n") }
	token PAIR { <KEY> ':' <VALUE> }
	token KEY { "byr" | "iyr" | "eyr" | "hgt" | "hcl" | "ecl" | "pid" | "cid" }
	token VALUE { \S+ }
}

class PPB-Actions {
	method TOP($/) {
		make $<RECORD>.map(*.made).cache;
	}
	method RECORD($/) {
		make Hash.new: $<PAIR>.map(*.made).cache;
	}
	method PAIR($/) {
		make $<KEY>.Str => $<VALUE>.Str;
	}
}

my $input = PPB.parse('input'.IO.slurp, actions => PPB-Actions.new).made;

my $REQUIRED = set <byr iyr eyr hgt hcl ecl pid>;

sub has-required-fields(%record) {
	return $REQUIRED ⊆ %record.keys;
}

say 'part 1 ', +$input.grep(-> %r { has-required-fields(%r); });

sub is-valid(% (:$byr, :$iyr, :$eyr, :$hgt, :$hcl, :$ecl, :$pid, :$cid)) {
	return False unless $byr ~~ /^ \d ** 4 $/ && 1920 <= +$byr <= 2002;
	return False unless $iyr ~~ /^ \d ** 4 $/ && 2010 <= +$iyr <= 2020;
	return False unless $eyr ~~ /^ \d ** 4 $/ && 2020 <= +$eyr <= 2030;
	with $hgt {
		when /^ (\d+) 'cm' $/ {
			return False unless 150 <= $0 <= 193;
		}
		when /^ (\d+) 'in' $/ {
			return False unless 59 <= $0 <= 76;
		}
		return False
	}
	return False unless $hcl ~~ /^ '#' <[0..9a..f]> ** 6 $/;
	return False unless $ecl ∈ set <amb blu brn gry grn hzl oth>;
	return False unless $pid ~~ /^ \d ** 9 $/;
	return True;
}

say 'part 2 ', +$input.grep(-> %r { has-required-fields(%r) && is-valid(%r); });
