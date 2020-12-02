sub parse(Str $l) {
	if ($l ~~ / (<[0..9]>+) '-' (<[0..9]>+) ' ' (<[a..z]>) ': ' (<[a..z]>+) /) {
		return ($0.Int, $1.Int, $2, $3);
	}
}
my @in = 'input'.IO.lines.map(&parse).cache;

sub is-valid($min, $max, $char, $pass) {
	return (+$pass.comb($char)) ~~ ($min..$max);
}

say +@in.grep(-> ($min, $max, $char, $pass) { is-valid($min, $max, $char, $pass) });

sub is-valid-p2($p1, $p2, $char, $pass) {
	return ($pass.substr-eq($char, $p1 - 1) + $pass.substr-eq($char, $p2 - 1)) == 1;
}

say +@in.grep(-> ($min, $max, $char, $pass) { is-valid-p2($min, $max, $char, $pass) });
