defmodule Calc do

  def eval(line) do
    line = clean_whitespace(line)
    line = solve_divi(line)
    line = solve_mult(line)
    line = solve_add(line)
    line = solve_sub(line)
    line
  end

  def solve_sub(line) do
    if is_number(line) do
      line
    else
      sub_index = find_last_index(line, "-")
      if sub_index == 0 do
        line
      else
        left = String.slice(line, 0, sub_index - 1)
        right = String.slice(line, sub_index, String.length(line))
        IO.puts("sub left " <> left <> " right " <> right)
        solution = sub(eval(left), eval(right))
        solution
      end
    end
  end

  def solve_add(line) do
    if is_number(line) do
      line
    else
      sub_index = find_last_index(line, "+")
      if sub_index == 0 do
        line
      else
        left = String.slice(line, 0, sub_index - 1)
        right = String.slice(line, sub_index, String.length(line))
        IO.puts("add left " <> left <> " right " <> right)
        solution = add(eval(left), eval(right))
        solution
      end
    end
  end

  def solve_mult(line) do
    if is_number(line) do
      line
    else
      sub_index = find_last_index(line, "*")
      if sub_index == 0 do
        line
      else
        left = String.slice(line, 0, sub_index - 1)
        right = String.slice(line, sub_index, String.length(line))
        IO.puts("multi left " <> left <> " right " <> right)
        solution = mult(eval(left), eval(right))
        solution
      end
    end
  end

  def solve_divi(line) do
    if is_number(line) do
      line
    else
      sub_index = find_last_index(line, "/")
      if sub_index == 0 do
        line
      else
        left = String.slice(line, 0, sub_index - 1)
        right = String.slice(line, sub_index, String.length(line))
        IO.puts("divi left " <> left <> " right " <> right)
        solution = divi(eval(left), eval(right))
        solution
      end
    end
  end

  def find_last_index(line, char) do
    length(String.codepoints line) - (length(Enum.take_while Enum.reverse(String.codepoints line) , fn(line) -> line != char end))
  end

  def clean_whitespace(line) do
    if is_number(line) do
      line
    else
      String.replace(line, " ", "")
    end
  end

  def parse_exp(x) do
    if is_number(x) do
      x
    else
      Integer.parse(x) |> elem(0)
    end
  end

  def add(x, y) do
    parse_exp(x) + parse_exp(y)
  end

  def sub(x, y) do
    parse_exp(x) - parse_exp(y)
  end

  def divi(x, y) do
    parse_exp(x) / parse_exp(y)
  end

  def mult(x, y) do
    parse_exp(x) * parse_exp(y)
  end
end
