defmodule Calc do
  def main() do
    input = IO.gets("Enter expression without parenthesis and hit enter \n")
    IO.puts(eval(input))
    main()
  end

  def eval(line) do
    line = clean_whitespace(line)
    line = solve_parenthesis(line)
    line = solve_multi_divi(line)
    line = solve_add_sub(line)
    parse_exp(line)
  end

  def solve_parenthesis(line) do
    if line =~ "(" do
      left_part = find_last_index(line, "(")
      right_part = find_first_p(String.slice(line, left_part, String.length(line) - left_part)) + left_part
      left_string = if (left_part == 0) do
        ""
      else
        String.slice(line, 0, left_part)
      end
      right_string = if right_part == String.length(line)-1 do
        ""
      else
        String.slice(line, right_part + 1, String.length(line) - right_part)
      end
      center = String.slice(line, left_part + 1, right_part - left_part - 1)
      line = left_string <> Float.to_string(eval(center)) <> right_string
      solve_parenthesis(line)
    else
      line
    end
  end

  def solve_multi_divi(line) do
    line = replace_sub(line)
    if line =~ "*" || line =~ "/" do
      mult_index = find_first_index(line, "*")
      divi_index = find_first_index(line, "/")
      if mult_index < divi_index do
        left_side = find_left(String.slice(line, 0, mult_index))
        right_side = find_right(String.slice(line, mult_index + 1, String.length(line)))
        left_side_val = String.slice(line, left_side, mult_index - left_side)
        right_side_val = String.slice(line, mult_index + 1, right_side + 1)
        new_val = mult(left_side_val, right_side_val)
        line = String.slice(line, 0, left_side) <> new_val <> String.slice(line, mult_index + right_side + 2, String.length(line) - mult_index + right_side + 2)
        solve_multi_divi(line)
      else
        left_side = find_left(String.slice(line, 0, divi_index))
        right_side = find_right(String.slice(line, divi_index + 1, String.length(line)))
        left_side_val = String.slice(line, left_side, divi_index - left_side)
        right_side_val = String.slice(line, divi_index + 1, right_side + 1)
        new_val = divi(left_side_val, right_side_val)
        line = String.slice(line, 0, left_side) <> new_val <> String.slice(line, divi_index + right_side + 2, String.length(line) - divi_index + right_side + 2)
        solve_multi_divi(line)
      end
    else
      line
    end
  end

  def solve_add_sub(line) do
    line = replace_sub(line)
    if line =~ "+" || String.slice(line, 1, String.length(line) - 1) =~ "-" do
      add_index = find_first_index(line, "+")
      sub_index = find_first_index(String.slice(line, 1, String.length(line) - 1), "-")
      sub_index = if sub_index == false do
        false
      else
        sub_index + 1
      end
      if add_index < sub_index do
        left_side = find_left(String.slice(line, 0, add_index))
        right_side = find_right(String.slice(line, add_index + 1, String.length(line)))
        left_side_val = String.slice(line, left_side, add_index - left_side)
        right_side_val = String.slice(line, add_index + 1, right_side + 1)
        new_val = add(left_side_val, right_side_val)
        line = String.slice(line, 0, left_side) <> new_val <> String.slice(line, add_index + right_side + 2, String.length(line) - add_index + right_side + 2)
        solve_add_sub(line)
      else
        left_side = find_left(String.slice(line, 0, sub_index))
        right_side = find_right(String.slice(line, sub_index + 1, String.length(line)))
        left_side_val = String.slice(line, left_side, sub_index - left_side)
        right_side_val = String.slice(line, sub_index + 1, right_side + 1)
        new_val = sub(left_side_val, right_side_val)
        line = String.slice(line, 0, left_side) <> new_val <> String.slice(line, sub_index + right_side + 2, String.length(line) - sub_index + right_side + 2)
        solve_add_sub(line)
      end
    else
      line
    end
  end

  def find_left(line) do
    min = -1
    mult_index = find_last_index(line, "*")
    divi_index = find_last_index(line, "/")
    add_index = find_last_index(line, "+")

    Enum.max([mult_index, divi_index, add_index, min]) + 1
  end

  def find_right(line) do
    max = String.length(line) + 1
    mult_index = find_first_index(line, "*")
    divi_index = find_first_index(line, "/")
    add_index = find_first_index(line, "+")

    Enum.min([mult_index, divi_index, add_index, max]) - 1
  end

  def clean_whitespace(line) do
    line = String.replace(line, " ", "")
    line = String.replace(line, "\n", "")
    String.replace(line, "\r", "")
  end

  #source Yvan Godin for line below https://groups.google.com/forum/#!topic/elixir-lang-talk/PKVDr7rBKRI
  def find_last_index(line, char) do
    length(String.codepoints line) - (length(Enum.take_while Enum.reverse(String.codepoints line) , fn(line) -> line != char end)) - 1
  end

  def find_first_index(line, char) do
    index = :binary.match(line, char)
    if index == :nomatch do
      false
    else
      if index |> elem(0) == 0 do
        false
      else
        index |> elem(0)
      end
    end
  end

  def find_first_p(line) do
    index = :binary.match(line, ")")
    index |> elem(0)
  end

  def replace_sub(line) do
    temp = String.slice(line, 1, String.length(line) - 1)
    temp = String.replace(temp, "--", "+")
    temp = String.replace(temp, "-", "+-")
    temp = String.replace(temp, "++", "+")
    temp = String.replace(temp, "/+", "/")
    temp = String.replace(temp, "*+", "*")
    String.slice(line, 0, 1) <> temp
  end

  def parse_exp(x) do
    Float.parse(x) |> elem(0)
  end

  def add(x, y) do
    res = parse_exp(x) + parse_exp(y)
    Float.to_string(res)
  end

  def sub(x, y) do
    res = parse_exp(x) - parse_exp(y)
    Float.to_string(res)
  end

  def divi(x, y) do
    res = parse_exp(x) / parse_exp(y)
    Float.to_string(res)
  end

  def mult(x, y) do
    res = parse_exp(x) * parse_exp(y)
    Float.to_string(res)
  end
end
