defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "add-1" do
    assert Calc.eval("30+2") == 30+2
  end

  test "add-2" do
    assert Calc.eval("-10+2") == -10+2
  end

  test "sub-1" do
    assert Calc.eval("10-2") == 10-2
  end

  test "sub-2" do
    assert Calc.eval("-10-2") == -10-2
  end

  test "div-1" do
    assert Calc.eval("10/2") == 10/2
  end

  test "div-2" do
  	assert Calc.eval("1/10") == 1/10
  end

  test "mult-1" do
  	assert Calc.eval("1*10") == 1*10
  end

  test "mult-2" do
  	assert Calc.eval("1*-10") == 1*-10
  end

  test "paren-1" do
  	assert Calc.eval("(1)") == (1)
  end

  test "paren-2" do
  	assert Calc.eval("3*(1+1)") == 3*(1+1)
  end

  test "all-1" do
  	assert Calc.eval("3+20+(2-30)/3-((3-2/40)*20)") == 3+20+(2-30)/3-((3-2/40)*20)
  end
end
