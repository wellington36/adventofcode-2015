-- Problem: https://adventofcode.com/2015/day/7

-- PART 1:
-- Defining input
def input_task : String := include_str "inputs/input_day7.txt"

def string_to_char_list (s : String) : List Char :=
  s.toList
