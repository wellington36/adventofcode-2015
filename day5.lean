-- Problem: https://adventofcode.com/2015/day/5

-- Defining input
def input_day5 : String := include_str "inputs/input_day5.txt"

def split_by_new_line (s : String) : List String :=
  s.split (· == '\n')

def input_task := split_by_new_line input_day5

-- Part 1:
def is_vowel (c : Char) : Bool :=
  c ∈ ['a', 'e', 'i', 'o', 'u']


def rule₁ (s : List Char) : Bool :=
  let num_vowels := s.foldl (λ acc c => if is_vowel c then acc + 1 else acc) 0
  num_vowels ≥ 3

def rule₂ : List Char -> Bool
  | []        => false
  | [_]       => false
  | c1 :: c2 :: rest => if c1 = c2 then true else rule₂ (c2 :: rest)


def rule₃ (s : List Char) : Bool :=
  let forbidden := ['a', 'b'] :: ['c', 'd'] :: ['p', 'q'] :: ['x', 'y'] :: []
  ¬(s.zip s.tail |>.any (λ ⟨c1, c2⟩ => forbidden.contains [c1, c2]))


def is_nice (s : String) : Bool :=
  let chars := s.toList
  rule₁ chars ∧ rule₂ chars ∧ rule₃ chars

def count_nice_strings (ss : List String) : Nat :=
  ss.foldl (λ acc s => if is_nice s then acc + 1 else acc) 0


#eval count_nice_strings input_task


-- Part 2:
