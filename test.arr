include shared-gdrive("fluid-images-support.arr",
  "1g2NXqb-7QVUdTo3GqyYWd8jvY1gcjaWJ")
include my-gdrive("fluid-images-code.arr")
include my-gdrive("fluid-images-common.arr")

# DO NOT CHANGE ANYTHING ABOVE THIS LINE
#
# Write your examples and tests in here. These should not be tests of
# implementation-specific details (e.g., helper functions).

check ```liquify-mem: return same image when second param is 0```:
  liquify-memoization(image-1x1-0, 0) is image-1x1-0
  liquify-memoization(image-1x2-0, 0) is image-1x2-0
  liquify-memoization(image-1x3-0, 0) is image-1x3-0
  liquify-memoization(image-2x1-0, 0) is image-2x1-0
  liquify-memoization(image-2x2-0, 0) is image-2x2-0
end

check ```liquify-mem: removes leftmost (completely vertical) when all seams
      are the same, remove 1 seam```:
  liquify-memoization(image-2x1-0, 1) is image-1x1-0
  liquify-memoization(image-2x2-0, 1) is image-1x2-0
  liquify-memoization(image-2x3-0, 1) is image-1x3-0
end

check ```liquify-mem: removes every possible combination of a seam in 3by3, remove 1 seam```:
  liquify-memoization(image-3x3-0, 1) is image-2x3-0
  liquify-memoization(image-3x3-1, 1) is image-2x3-1
  liquify-memoization(image-3x3-2, 1) is image-2x3-2
  liquify-memoization(image-3x3-3, 1) is image-2x3-3
  liquify-memoization(image-3x3-4, 1) is image-2x3-4
  liquify-memoization(image-3x3-8, 1) is image-2x3-8
  liquify-memoization(image-3x3-10, 1) is image-2x3-10
end

check ```liquify-mem: removes leftmost (not completely vertical) when some
   seams are the same, remove 1 seam```:
  liquify-memoization(image-3x3-confl-0, 1) is image-2x3-confl-0
  liquify-memoization(image-3x3-confl-1, 1) is image-2x3-confl-1
end

check ```liquify-mem: conflict first removal, not second```:
  liquify-memoization(image-3x3-confl-0, 2) is image-1x3-confl-0
end

check ```liquify-mem: conflict first and second removal```:
  liquify-memoization(image-3x3-confl-1, 2) is image-1x3-confl-1
end




check ```liquify-dynamic-programming: return same image when second param is 0```:
  liquify-dynamic-programming(image-1x1-0, 0) is image-1x1-0
  liquify-dynamic-programming(image-1x2-0, 0) is image-1x2-0
  liquify-dynamic-programming(image-1x3-0, 0) is image-1x3-0
  liquify-dynamic-programming(image-2x1-0, 0) is image-2x1-0
  liquify-dynamic-programming(image-2x2-0, 0) is image-2x2-0
end

check ```liquify-dynamic-programming: removes leftmost (completely vertical) when all seams
      are the same, remove 1 seam```:
  liquify-dynamic-programming(image-2x1-0, 1) is image-1x1-0
  liquify-dynamic-programming(image-2x2-0, 1) is image-1x2-0
  liquify-dynamic-programming(image-2x3-0, 1) is image-1x3-0
end

check ```liquify-dynamic-programming: removes every possible combination of a seam in 3by3, remove 1 seam```:
  liquify-dynamic-programming(image-3x3-0, 1) is image-2x3-0
  liquify-dynamic-programming(image-3x3-1, 1) is image-2x3-1
  liquify-dynamic-programming(image-3x3-2, 1) is image-2x3-2
  liquify-dynamic-programming(image-3x3-3, 1) is image-2x3-3
  liquify-dynamic-programming(image-3x3-4, 1) is image-2x3-4
  liquify-dynamic-programming(image-3x3-8, 1) is image-2x3-8
  liquify-dynamic-programming(image-3x3-10, 1) is image-2x3-10
end

check ```liquify-dynamic-programming: removes leftmost (not completely vertical) when some
   seams are the same, remove 1 seam```:
  liquify-dynamic-programming(image-3x3-confl-0, 1) is image-2x3-confl-0
  liquify-dynamic-programming(image-3x3-confl-1, 1) is image-2x3-confl-1
end

check ```liquify-dynamic-programming: conflict first removal, not second```:
  liquify-dynamic-programming(image-3x3-confl-0, 2) is image-1x3-confl-0
end


check ```liquify-dynamic-programming: conflict first and second removal```:
  liquify-dynamic-programming(image-3x3-confl-1, 2) is image-1x3-confl-1
end

check ```liquify-dynamic-programming:greedy algorithm doesn't work```:
  liquify-dynamic-programming(image-4x4, 1) is image-4x4-sol
end

check ```liquify-memoize:greedy algorithm doesn't work```:
  liquify-memoization(image-4x4, 1) is image-4x4-sol
end




