require "test_helper"

class CellTest < ActiveSupport::TestCase
  test "initializeCellWithWrongX" do
    exceptionMessage = ""
    begin
      Cell.new(-1, 0, true)
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "initializeCellWithWrongY" do
    exceptionMessage = ""
    begin
      Cell.new(0, -1, true)
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "initializeCellWithWrongStatus" do
    exceptionMessage = ""
    begin
      Cell.new(0, 0, 3)
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "initializeCellWithRightParameters" do
    cell = Cell.new(0, 0, true)
    assert cell.class == Cell
  end

  test "equalsWithDifferentX" do
    cell1 = Cell.new(0, 0, true)
    cell2 = Cell.new(1, 0, true)

    assert_not cell1 == cell2
  end

  test "equalsWithDifferentY" do
    cell1 = Cell.new(0, 0, true)
    cell2 = Cell.new(0, 1, true)

    assert_not cell1 == cell2
  end

  test "equalsWithDifferentStatus" do
    cell1 = Cell.new(0, 0, true)
    cell2 = Cell.new(0, 0, false)

    assert_not cell1 == cell2
  end

  test "okEquals" do
    cell1 = Cell.new(0, 0, true)
    cell2 = Cell.new(0, 0, true)

    assert cell1 == cell2
  end

end