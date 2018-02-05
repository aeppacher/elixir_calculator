defmodule Calc do

  def eval(line) do
    cleaned_line = clean_whitespace(line)
    
    cleaned_line = solve_parenthesis(line)
  end

  def solve_parenthesis(line)
  
  end

  def clean_whitespace(line) do
    String.replace(line, " ", "")
  end

  def add(x, y) do
    x + y
  end

  def sub(x, y) do
    x - y
  end

  def div(x, y) do
    x / y
  end

  def mult(x, y) do
    x * y
  end
end
