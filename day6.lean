-- Problem: https://adventofcode.com/2015/day/6

-- Defining input
def input_day6 : String := include_str "inputs/input_day6.txt"

def split_by_new_line (s : String) : List String :=
  s.split (· == '\n')

def input_task := split_by_new_line input_day6

def test_input := ["toggle 489,959 through 759,964", "turn off 820,516 through 871,914", "turn off 427,423 through 929,502"]

-- Define the grid as a list of lists of booleans, where each inner list represents a row of lights.
def initial_grid : List (List Bool) :=
  List.replicate 1000 (List.replicate 1000 false)

-- Apply an action to a sub-grid of the main grid
def apply_action (grid : List (List Bool)) (action : String) (x1 y1 x2 y2 : Nat) : List (List Bool) :=
  grid.enum.map (λ ⟨i, row⟩ =>
    if x1 ≤ i ∧ i ≤ x2 then
      row.enum.map (λ ⟨j, light⟩ =>
        if y1 ≤ j ∧ j ≤ y2 then
          match action with
          | "turn on"  => true
          | "turn off" => false
          | "toggle"   => ¬ light
          | _          => light  -- Default case, should not occur
        else light)
    else row)

-- Count the total number of lights that are on (i.e., true) in the grid
def count_lights (grid : List (List Bool)) : Nat :=
  grid.foldl (λ acc row => acc + row.foldl (λ acc2 light => acc2 + if light then 1 else 0) 0) 0

-- Process a list of instructions and return the final count of lights that are on
def solve (instructions : List (String × Nat × Nat × Nat × Nat)) : Nat :=
  let
    final_grid := instructions.foldl (λ grid instruction =>
      apply_action grid instruction.1 instruction.2.1 instruction.2.2.1 instruction.2.2.2.1 instruction.2.2.2.2) initial_grid
  count_lights final_grid

def parse_instruction (instr : String) : (String × Nat × Nat × Nat × Nat) :=
  let parts := instr.splitOn " through "
  let cmd := parts.head! -- Get the command part
  let range := parts.tail!.head! -- Get the range part
  let coordinates := cmd.splitOn " " -- Split the command to get the action
  let action := (coordinates.head! ++ " " ++ coordinates.tail!.head!) -- The action (e.g., "turn on")
  let coord_parts := coordinates.tail! -- The rest should contain the starting coordinates
  let start_coords := coord_parts.head!.splitOn "," -- Split by comma
  let end_coords := range.splitOn "," -- Split the range by comma

  -- Convert strings to Nat
  let x1 := String.toNat! start_coords.head!
  let y1 := String.toNat! start_coords.tail!.head!
  let x2 := String.toNat! end_coords.head!
  let y2 := String.toNat! end_coords.tail!.head!

  (action, x1, y1, x2, y2)


-- Convert the example_instructions to a list of parsed tuples
def parsed_instructions : List (String × Nat × Nat × Nat × Nat) :=
  test_input.map parse_instruction

-- Example usage with a list of instructions
#eval parsed_instructions
