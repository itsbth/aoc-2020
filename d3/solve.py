from functools import reduce

product = lambda l: reduce(lambda x, y: x * y, l, 1)

mm = [list(m.strip()) for m in open("input")]


def sweep(xs, ys):
    c = 0
    x = 0
    for y in range(0, len(mm), ys):
        if mm[y][x] == "#":
            c += 1
        x = (x + xs) % len(mm[y])
    return c


print("part 1", sweep(3, 1))

ls = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]


print("part 2", product(sweep(x, y) for (x, y) in ls))
