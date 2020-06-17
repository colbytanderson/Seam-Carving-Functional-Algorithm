provide *
provide-types *

include shared-gdrive("fluid-images-support.arr",
  "1g2NXqb-7QVUdTo3GqyYWd8jvY1gcjaWJ")
include my-gdrive("fluid-images-common.arr")


# DO NOT CHANGE ANYTHING ABOVE THIS LINE
#
# You may write implementation-specific tests (e.g., of helper functions)
# in this file.

data Position: pos(r :: Number, c :: Number) end 
type Seam = List<Position>
data Path: path(seam :: Seam, dist :: Number) end
type Matrix = List<List<Number>>

fun liquify-memoization(input :: Image, n :: Number) -> Image:
  doc: "removes the minimum seam n times"
  if n == 0: input
  else:
    energy-matrix = image-to-energy-matrix(input)
    row-length = input.height
    col-length = input.width
    rec get-minimum-seam =
      memoize(
        lam(matrix :: Matrix, position :: Position, height :: Number,
            width :: Number) -> Path:
          doc: "find minimum seam given a row and column"
          energy = matrix-get(matrix, position).value
          child-to-seam = {(child-position):
            child-path = get-minimum-seam(matrix, child-position, height, width)
            path(link(position, child-path.seam), energy + child-path.dist)}
          ask:
            | position.r == height then: path([list: position], energy)
            | otherwise:
              children-seams =
                get-children(position, height, width, child-to-seam)
              minimum(children-seams, {(c-path): c-path.dist})
          end
        end, row-length, col-length)
    min-seams = map_n({(i, _):
        get-minimum-seam(energy-matrix, pos(1, i), row-length, col-length)},
      1, energy-matrix.first)
    min-seam = minimum(min-seams, {(x): x.dist})
    res = image-data-to-image(col-length - 1, row-length,
      remove-seam(input, min-seam.seam))
  liquify-memoization(res, n - 1) end
end

fun memoize(f, row :: Number, col :: Number):
  memory = build-array({(_): array-of(none, col)}, row)
  lam(mat :: Matrix, p :: Position, height :: Number, width :: Number) -> Path:
    res = memory.get-now(p.r - 1).get-now(p.c - 1)
    cases (Option) res block:
      | some(ans) => ans
      | none => actual = f(mat, p, height, width)
        memory.get-now(p.r - 1).set-now(p.c - 1, some(actual))
        actual
    end
  end
end

fun calc-energy(mat :: Matrix, p :: Position) -> Number:
  doc: "calculates energy for given position in matrix"
  convert = {(opt): cases (Option) opt: |none => 0 |some(a) => a end}
  val = {(posi): convert(matrix-get(mat, posi))}
  a = val(pos(p.r - 1, p.c - 1))
  b = val(pos(p.r - 1, p.c))
  c = val(pos(p.r - 1, p.c + 1))
  d = val(pos(p.r, p.c - 1))
  f = val(pos(p.r, p.c + 1))
  g = val(pos(p.r + 1, p.c - 1))
  h = val(pos(p.r + 1, p.c))
  i = val(pos(p.r + 1, p.c + 1))
  x-energy = (a + (2 * d) + g) - (c + (2 * f) + i)
  y-energy = (a + (2 * b) + c) - (g + (2 * h) + i)
  num-sqrt(num-sqr(x-energy) + num-sqr(y-energy))
end

fun matrix-get(mat :: Matrix, p :: Position) -> Option<Number>:
  doc: "returns elt with given position in matrix"
  amt-of-rows = mat.length()
  amt-of-cols = mat.first.length()
  undef-row = (p.r < 1) or (p.r > amt-of-rows)
  undef-col = (p.c < 1) or (p.c > amt-of-cols)
  if (undef-row) or (undef-col): none
  else: some(mat.get(p.r - 1).get(p.c - 1)) end
end

fun remove-seam(img :: Image, seam :: Seam) -> List<List<Color>>:
  doc: "removes given seam and returns new image"
  cases (List) seam:
    | empty => empty
    | link(f, r) => link(remove(img.pixels.get(f.r - 1), f.c - 1),
        remove-seam(img, r))
  end
end

fun liquify-dynamic-programming(input :: Image, n :: Number) -> Image:
  doc: "removes the minimum seam n times"
  if n == 0: input
  else: block:
      mat = image-to-energy-matrix(input)
      memory = build-array({(_): array-of(none, input.width)}, input.height)
      setup-seams(mat, input.height, memory, input.height, input.width)
      row1 = memory.get-now(0).to-list-now().map({(e): e.value})
      row1c = row1.sort-by({(a, b): a.seam.first.c < b.seam.first.c},
        {(a, b): a.seam.first.c == b.seam.first.c})
      min = minimum(row1c, {(elt): elt.dist})
      res = image-data-to-image(input.width - 1, input.height,
        remove-seam(input, min.seam))
  liquify-dynamic-programming(res, n - 1) end end
end

fun setup-seams(mat :: Matrix, row :: Number, memory, height, width): 
  if row == 0: 1
  else: block:
      map_n({(n, elt):
          en = matrix-get(mat, pos(row, n)).value
          search = {(p): memory.get-now(p.r - 1).get-now(p.c - 1)}
          children = get-children(pos(row, n), height, width, search)
          chs = children.map({(c): c.value})
          min = if is-empty(chs): 0 else: minimum(chs, {(x): x.dist}) end
          out = if row == height: 
            path([list: pos(row, n)], en)
          else:
            path(link(pos(row, n), min.seam), en + min.dist)
          end
          memory.get-now(row - 1).set-now(n - 1, some(out))}, 1,
        mat.get(row - 1))
    setup-seams(mat, row - 1, memory, height, width) end
  end
end

fun get-children<A>(index :: Position, height :: Number, width :: Number,
    func :: (Position -> A)) -> List<A>:
  doc: "gets-children of inputted matrix index. height, width must be > than 0"
  row = index.r
  col = index.c
  row-bel = index.r + 1
  child-left = pos(row-bel, col - 1)
  child-middle = pos(row-bel, col)
  child-right = pos(row-bel, col + 1)
  ask:
    | row == height then: empty
    | width == 1 then: [list: func(child-middle)]
    | col == 1 then: [list: func(child-middle), func(child-right)]
    | col == width then: [list: func(child-left), func(child-middle)]
    | otherwise:
      [list: func(child-left), func(child-middle), func(child-right)]
  end
end

fun image-to-energy-matrix(img :: Image) -> Matrix:
  doc: "maps each pixel with an energy, forming an energy matrix"
  pix = img.pixels.map({(r): r.map({(p): p.red + p.green + p.blue})})
  map_n({(rn, r):
      map_n({(cn, elt): calc-energy(pix, pos(rn, cn))}, 1, r)}, 1, pix)
end

check "get-children: left-most column":
  get-children(pos(1, 1), 3, 5, {(x): x}) is [list: pos(2, 1), pos(2, 2)]
end
check "get-children: right-most column":
  get-children(pos(1, 3), 2, 3, {(x): x}) is [list: pos(2, 2), pos(2, 3)]
end
check "get-children: middle column":
  get-children(pos(2, 2), 4, 4, {(x): x}) is
  [list: pos(3, 1), pos(3, 2), pos(3, 3)]
end
check "get-children: last row":
  get-children(pos(3, 1), 3, 4, {(x): x}) is empty
end
check "get-children: single column":
  get-children(pos(4, 1), 5, 1, {(x): x}) is [list: pos(5, 1)]
end
check "image-to-energy-matrix: non-square matrix":
  image-to-energy-matrix(image-2x3-1) is-roughly [list:
    [list: 27.16615541441225, 8.48528137423857],
    [list: 24.20743687382041, 24.331050121192877],
    [list: 5.830951894845301, 6.324555320336759]]
  image-to-energy-matrix(image-4x4-sol) is-roughly [list:
    [list: 11.313708498984761, 24.20743687382041, 16.1245154965971],
    [list: 19.849433241279208, 10, 13.038404810405298],
    [list: 13.92838827718412, 8.94427190999916, 17.029386365926403],
    [list: 12.727922061357855, 15.811388300841896, 9.486832980505138]]
end

check "image-to-energy-matrix: square matrix":
  image-to-energy-matrix(image-3x3-2) is-roughly [list:
    [list: 7.211102550927978, 19.6468827043885, 8.48528137423857],
    [list: 8.94427190999916, 15.620499351813308, 21.540659228538015],
    [list: 10.770329614269007, 5.830951894845301, 11.661903789690601]]
  image-to-energy-matrix(image-4x4) is-roughly [list:
    [list: 11.313708498984761, 21.633307652783937, 13.341664064126334,
      13.416407864998739],
    [list: 19.849433241279208, 14.422205101855956, 4.242640687119285,
      6.324555320336759],
    [list: 13.92838827718412, 11.045361017187261, 12.806248474865697,
      12.165525060596439],
    [list: 12.727922061357855, 15.811388300841896, 9.486832980505138, 0]]
end

check "setup-seams":
  mat = image-to-energy-matrix(image-2x3-confl-1)
  h = image-2x3-confl-1.height
  w = image-2x3-confl-1.width
  memory = build-array({(_): array-of(none, w)}, h)
  setup-seams(mat, 3, memory, h, w)
  memory.get-now(0).to-list-now().map({(o): o.value.seam}) is
  [list: [list: pos(1, 1), pos(2, 2), pos(3, 2)],
    [list: pos(1, 2), pos(2, 2), pos(3, 2)]]
  memory.get-now(1).to-list-now().map({(o): o.value.seam}) is
  [list: [list: pos(2, 1), pos(3, 2)], [list: pos(2, 2), pos(3, 2)]]
  memory.get-now(2).to-list-now().map({(o): o.value.seam}) is
  [list: [list: pos(3, 1)], [list: pos(3, 2)]]
  
  memory.get-now(0).to-list-now().map({(o): o.value.dist}) is-roughly
  [list: 22.767451737032026, 22.767451737032026]
  memory.get-now(1).to-list-now().map({(o): o.value.dist}) is-roughly
  [list: 15.457313802163299, 14.282170362793455]
  memory.get-now(2).to-list-now().map({(o): o.value.dist}) is-roughly
  [list: 8.48528137423857, 7.211102550927978]
end

check "calc-energy: 1 row":
  calc-energy([list: [list: 1]], pos(1, 1)) is 0
  calc-energy([list: [list: 1, 5]], pos(1, 1)) is 10
  calc-energy([list: [list: 1, 5, 3]], pos(1, 2)) is 4
  calc-energy([list: [list: 1, 5, 3]], pos(1, 3)) is 10
end

check "calc-energy: 3 row":
  calc-energy([list: [list: 1, 5, 3], [list: 4, 2, 9],
      [list: 10, 6, 7]], pos(3, 3)) is-roughly 24.413111231467404
  calc-energy([list: [list: 1, 5, 3], [list: 4, 2, 9],
      [list: 10, 6, 7]], pos(2, 2)) is-roughly 17.4928556845359
  calc-energy([list: [list: 1, 5, 3], [list: 4, 2, 9],
      [list: 10, 6, 7]], pos(2, 1)) is-roughly 24.20743687382041
  calc-energy([list: [list: 1, 5, 3], [list: 4, 2, 9],
      [list: 10, 6, 7]], pos(1, 1)) is-roughly 15.620499351813308
  calc-energy([list: [list: 1, 5, 3], [list: 4, 2, 9],
      [list: 10, 6, 7]], pos(1, 3)) is-roughly 23.323807579381203
  calc-energy([list: [list: 1, 5, 3], [list: 4, 2, 9],
      [list: 10, 6, 7]], pos(3, 1)) is-roughly 17.204650534085253
end

check "matrix-get: returns none":
  matrix-get([list: [list: 1]], pos(0, 0)) is none
  matrix-get([list: [list: 1]], pos(2, 0)) is none
end

check "matrix-get: 1 row":
  matrix-get([list: [list: 2, 5, 4]], pos(1, 1)) is some(2)
  matrix-get([list: [list: 2, 5, 4]], pos(1, 2)) is some(5)
  matrix-get([list: [list: 2, 5, 4]], pos(1, 3)) is some(4)
  matrix-get([list: [list: 2, 5, 4]], pos(1, 4)) is none
end

check "matrix-get: 2 rows":
  matrix-get([list: [list: 2, 3], [list: 4, 1]], pos(1, 1)) is some(2)
  matrix-get([list: [list: 2, 3], [list: 4, 1]], pos(1, 2)) is some(3)
  matrix-get([list: [list: 2, 3], [list: 4, 1]], pos(2, 1)) is some(4)
  matrix-get([list: [list: 2, 3], [list: 4, 1]], pos(2, 2)) is some(1)
  matrix-get([list: [list: 2, 3], [list: 3, 1]], pos(1, 3)) is none
end

check "remove-seam: 1 row":
  remove-seam(image-3x1-1, [list: pos(1, 1)])
    is image-2x1-sol-first
  remove-seam(image-3x1-1, [list: pos(1, 2)])
    is image-2x1-sol-mid
  remove-seam(image-3x1-1, [list: pos(1, 3)])
    is image-2x1-sol-last
end

check "remove-seam: 2 rows":
  remove-seam(image-3x2-1, [list: pos(1, 1), pos(2, 2)])
    is image-2x2-sol-first-mid
  remove-seam(image-3x2-1, [list: pos(1, 2), pos(2, 2)])
    is image-2x2-sol-mid-mid
  remove-seam(image-3x2-1, [list: pos(1, 3), pos(2, 3)])
    is image-2x2-sol-last-last
  remove-seam(image-3x2-1, [list: pos(1, 2), pos(2, 3)])
    is image-2x2-sol-mid-last
end

fun minimum<A>(l :: List<A>, func :: (A -> Number)) -> A:
  doc: "returns leftmost minimum value in list"
  cases (List) l:
    | empty => raise("Empty List")
    | link(f, r) =>
      cases (List) r:
        | empty => f
        | link(x, z) =>
          if func(f) <= func(x): minimum(link(f, z), func)
          else: minimum(r, func) end
      end
  end
where:
  minimum(empty, {(x): x}) raises "Empty List" # base case
  minimum([list: 9], {(x): x}) is 9 # 1 elt
  minimum([list: 9, 4, 2], {(x): x}) is 2 # last elt
  minimum([list: 3, 4, 9], {(x): x}) is 3 # first elt
  minimum([list: 9, 3, 3, 5], {(x): x}) is 3 # duplicates
  minimum([list: 9, 4, 2, 6, 3, 1, 19, 11], {(x): x}) is 1
end

fun remove<A>(l :: List<A>, ind :: Number) -> List<A>:
  doc: "removes elt at given index in list"
  cases (List) l:
    | empty => empty
    | link(f, r) => if ind == 0: r else: link(f, remove(r, ind - 1)) end
  end
where:
  remove(empty, 0) is empty # base case
  remove([list: 2, 1, 5, 4], 2) is [list: 2, 1, 4] # index in list
  remove([list: 2, 1], -1) is [list: 2, 1] # index not in list
  remove([list: 2, 1], 20) is [list: 2, 1] # index not in list
  remove([list: 3, 2, 2, 3, 4], 3) is [list: 3, 2, 2, 4] # duplicates
  remove([list: 3, 1, 4], 0) is [list: 1, 4] # first elt
  remove([list: 3, 1, 4], 2) is [list: 3, 1] # last elt
end



