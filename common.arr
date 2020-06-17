provide *
provide-types *

include shared-gdrive("fluid-images-support.arr",
  "1g2NXqb-7QVUdTo3GqyYWd8jvY1gcjaWJ")

# DO NOT CHANGE ANYTHING ABOVE THIS LINE
#
# Write data bindings here that you'll need for tests in both
# fluid-images-code.arr and fluid-images-tests.arr


image-1x1-0 = [image(1, 1):
  color(0, 0, 0)]
image-2x1-0 = [image(2, 1):
  color(0, 0, 0), color(0, 0, 0)]
image-3x1-0 = [image(3, 1):
  color(0, 0, 0), color(0, 0, 0), color(0, 0, 0)]

image-3x1-1 = [image(3, 1):
  color(2, 0, 0), color(3, 0, 0), color(4, 0, 0)]
image-2x1-sol-first = [list:
  [list: color(3, 0, 0), color(4, 0, 0)]]
image-2x1-sol-mid = [list:
  [list: color(2, 0, 0), color(4, 0, 0)]]
image-2x1-sol-last = [list:
  [list: color(2, 0, 0), color(3, 0, 0)]]

image-3x2-1 = [image(3, 2):
  color(2, 0, 0), color(3, 0, 0), color(4, 0, 0),
  color(5, 0, 0), color(6, 0, 0), color(7, 0, 0)]
image-2x2-sol-first-mid = [list:
  [list: color(3, 0, 0), color(4, 0, 0)],
  [list: color(5, 0, 0), color(7, 0, 0)]]
image-2x2-sol-mid-mid = [list:
  [list: color(2, 0, 0), color(4, 0, 0)],
  [list: color(5, 0, 0), color(7, 0, 0)]]
image-2x2-sol-last-last = [list:
  [list: color(2, 0, 0), color(3, 0, 0)],
  [list: color(5, 0, 0), color(6, 0, 0)]]
image-2x2-sol-mid-last = [list:
  [list: color(2, 0, 0), color(4, 0, 0)],
  [list: color(5, 0, 0), color(6, 0, 0)]]







image-1x2-0 = [image(1, 2):
  color(0, 0, 0),
  color(0, 0, 0)]
image-1x3-0 = [image(1, 3):
  color(0, 0, 0),
  color(0, 0, 0),
  color(0, 0, 0)]


image-2x2-0 = [image(2, 2):
  color(0, 0, 0), color(0, 0, 0),
  color(0, 0, 0), color(0, 0, 0)]
image-3x2-0 = [image(2, 3):
  color(0, 0, 0), color(0, 0, 0), color(0, 0, 0),
  color(0, 0, 0), color(0, 0, 0), color(0, 0, 0)]


image-2x3-0 = [image(2, 3):
  color(0, 0, 0), color(0, 0, 0),
  color(0, 0, 0), color(0, 0, 0),
  color(0, 0, 0), color(0, 0, 0)]


image-3x3-0 = [image(3, 3):
  color(0, 0, 0), color(0, 0, 0), color(0, 0, 0),
  color(0, 0, 0), color(0, 0, 0), color(0, 0, 0),
  color(0, 0, 0), color(0, 0, 0), color(0, 0, 0)]

# 3x3-1 (1,1), (2,1), (3,1)
image-3x3-1 = [image(3, 3):
  color(3, 0, 0), color(3, 0, 0), color(12, 0, 0),
  color(2, 0, 0), color(0, 0, 0), color(3, 0, 0),
  color(0, 0, 0), color(1, 0, 0), color(1, 0, 0)]

image-2x3-1 = [image(2, 3):
  color(3, 0, 0), color(12, 0, 0),
  color(0, 0, 0), color(3, 0, 0),
  color(1, 0, 0), color(1, 0, 0)]

# 3x3-2 (1,1), (2,1), (3,2)
image-3x3-2 = [image(3, 3):
  color(3, 0, 0), color(3, 0, 0), color(6, 5, 1),
  color(2, 0, 0), color(0, 0, 0), color(3, 0, 0),
  color(0, 0, 0), color(5, 0, 0), color(1, 0, 0)]

image-2x3-2 = [image(2, 3):
  color(3, 0, 0), color(6, 5, 1),
  color(0, 0, 0), color(3, 0, 0),
  color(0, 0, 0), color(1, 0, 0)]

# 3x3-3 is (1,1), (2,2), (3,1)
image-3x3-3 = [image(3, 3):
  color(0, 0, 0), color(2, 0, 0), color(2, 0, 0),
  color(0, 0, 0), color(3, 0, 0), color(2, 0, 0),
  color(0, 0, 0), color(2, 0, 0), color(2, 0, 0)]

image-2x3-3 = [image(2, 3):
  color(2, 0, 0), color(2, 0, 0),
  color(0, 0, 0), color(2, 0, 0),
  color(2, 0, 0), color(2, 0, 0)]

# 3x3-4 is (1,1), (2,2), (3,2)
image-3x3-4 = [image(3, 3):
  color(3, 0, 0), color(3, 0, 0), color(12, 0, 0),
  color(2, 0, 0), color(4, 0, 0), color(3, 0, 0),
  color(4, 0, 0), color(5, 0, 0), color(1, 0, 0)]

image-2x3-4 = [image(2, 3):
  color(3, 0, 0), color(12, 0, 0),
  color(2, 0, 0), color(3, 0, 0),
  color(4, 0, 0), color(1, 0, 0)]

# 3x3-8 is (1,2), (2,1), (3,1)
image-3x3-8 = [image(3, 3):
  color(0, 0, 0), color(9, 0, 0), color(2, 0, 0),
  color(2, 0, 0), color(2, 0, 0), color(3, 0, 0),
  color(2, 0, 0), color(1, 0, 0), color(0, 0, 0)]

image-2x3-8 = [image(2, 3):
  color(0, 0, 0), color(2, 0, 0),
  color(2, 0, 0), color(3, 0, 0),
  color(1, 0, 0), color(0, 0, 0)]

# 3x3-10 is (1,2), (2,2), (3,1)
image-3x3-10 = [image(3, 3):
  color(0, 0, 0), color(9, 0, 0), color(2, 0, 0),
  color(2, 0, 0), color(2, 0, 0), color(3, 0, 0),
  color(2, 0, 0), color(1, 0, 0), color(10, 0, 0)]

image-2x3-10 = [image(2, 3):
  color(0, 0, 0), color(2, 0, 0),
  color(2, 0, 0), color(3, 0, 0),
  color(1, 0, 0), color(10, 0, 0)]

# 3x3-confl is (1,2), (2,2), (3,1)
image-3x3-confl-0 = [image(3, 3):
  color(0, 0, 0), color(9, 0, 0), color(2, 0, 0),
  color(2, 0, 0), color(2, 0, 0), color(2, 0, 0),
  color(2, 0, 0), color(1, 0, 0), color(10, 0, 0)]

image-2x3-confl-0 = [image(2, 3):
  color(0, 0, 0), color(2, 0, 0),
  color(2, 0, 0), color(2, 0, 0),
  color(1, 0, 0), color(10, 0, 0)]

image-1x3-confl-0 = [image(1, 3):
  color(0, 0, 0),
  color(2, 0, 0),
  color(1, 0, 0)]

# 3x3-confl is (1,1), (2,2), (3,1)
image-3x3-confl-1 = [image(3, 3):
  color(0, 0, 0), color(2, 0, 0), color(2, 0, 0),
  color(2, 0, 0), color(4, 0, 0), color(2, 0, 0),
  color(2, 0, 0), color(1, 0, 0), color(2, 0, 0)]

image-2x3-confl-1 = [image(2, 3):
  color(2, 0, 0), color(2, 0, 0),
  color(2, 0, 0), color(2, 0, 0),
  color(1, 0, 0), color(2, 0, 0)]
#confl again, rem (1,1), (2,2), (3,2)
image-1x3-confl-1 = [image(1, 3):
  color(2, 0, 0),
  color(2, 0, 0),
  color(1, 0, 0)]


image-4x4 = [image(4, 4):
  color(5, 0, 6), color(2, 0, 0), color(2, 0, 0), color(0, 0, 0),
  color(2, 0, 0), color(4, 0, 0), color(2, 0, 0), color(5, 0, 0),
  color(3, 0, 0), color(3, 0, 0), color(0, 0, 0), color(0, 0, 0),
  color(1, 4, 0), color(3, 0, 0), color(0, 0, 0), color(0, 0, 0)]

image-4x4-sol = [image(3, 4):
  color(5, 0, 6), color(2, 0, 0), color(0, 0, 0),
  color(2, 0, 0), color(4, 0, 0), color(5, 0, 0),
  color(3, 0, 0), color(3, 0, 0), color(0, 0, 0),
  color(1, 4, 0), color(3, 0, 0), color(0, 0, 0)]

