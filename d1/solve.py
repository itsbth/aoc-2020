from itertools import combinations
from functools import reduce
from operator import mul

nums = [int(line) for line in open('input')]

print(reduce(mul, next(r for r in combinations(nums, 2) if sum(r) == 2020)))
print(reduce(mul, next(r for r in combinations(nums, 3) if sum(r) == 2020)))
