require "test_helper"

class WorldTest < ActiveSupport::TestCase
  test "initializeWorldWithWrongGeneration" do
    exceptionMessage = ""
    begin
      World.new(-1, 4, 8)
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "initializeWorldWithWrongRows" do
    exceptionMessage = ""
    begin
      World.new(0, -1, 8)
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "initializeWorldWithWrongCols" do
    exceptionMessage = ""
    begin
      World.new(0, 4, -1)
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "initializeWorldWithRightParameters" do
    assert World.new(0, 4, 8).class == World
  end

  test "equalsWith2WorldWithDifferentRows" do
    world1 = World.new(0, 4, 8)
    world2 = World.new(0, 3, 8)

    assert_not world1 == world2
  end

  test "equalsWith2WorldWithDifferentCols" do
    world1 = World.new(0, 4, 8)
    world2 = World.new(0, 4, 5)

    assert_not world1 == world2
  end

  test "wrongEquals" do
    world1 = World.new(0, 4, 8)
    world2 = World.new(0, 4, 8)
    world2.edit_cell_value(0, 0, true)

    assert_not world1 == world2
  end

  test "okEquals" do
    world1 = World.new(0, 4, 8)
    world2 = World.new(0, 4, 8)

    assert world1 == world2
  end

  test "editCellValueWithWrongX" do
    exceptionMessage = ""
    world = World.new(0, 4, 8)
    begin
      world.edit_cell_value(-1, 0, true)
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "editCellValueWithXNotInWorld" do
    exceptionMessage = ""
    world = World.new(0, 4, 8)
    begin
      world.edit_cell_value(5, 0, true)
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "editCellValueWithWrongY" do
    exceptionMessage = ""
    world = World.new(0, 4, 8)
    begin
      world.edit_cell_value(0, -1, true)
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "editCellValueWithYNotInWorld" do
    exceptionMessage = ""
    world = World.new(0, 4, 8)
    begin
      world.edit_cell_value(0, 9, true)
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "editCellValueWithWrongValue" do
    exceptionMessage = ""
    world = World.new(0, 4, 8)
    begin
      world.edit_cell_value(0, 0, 3)
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "editCellValueWithRightParameters" do
    world = World.new(0, 4, 8)
    world.edit_cell_value(0, 0, true)

    assert world.world.at(0).at(0).status == true
  end

  test "neighboursAliveWithWrongX" do
    exceptionMessage = ""
    world = World.new(0, 4, 8)
    begin
      world.neighbours_alive(-1, 0)
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "neighboursAliveWithXNotInWorld" do
    exceptionMessage = ""
    world = World.new(0, 4, 8)
    begin
      world.neighbours_alive(5, 0)
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "neighboursAliveWithWrongY" do
    exceptionMessage = ""
    world = World.new(0, 4, 8)
    begin
      world.neighbours_alive(0, -1)
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "neighboursAliveWithYNotInWorld" do
    exceptionMessage = ""
    world = World.new(0, 4, 8)
    begin
      world.neighbours_alive(0, 9)
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "neighboursAliveCalculation" do
    world = World.new(0, 4, 8)
    world.edit_cell_value(1, 4, true)
    world.edit_cell_value(2, 5, true)
    world.edit_cell_value(3, 3, true)
    world.edit_cell_value(3, 4, true)
    world.edit_cell_value(3, 5, true)

    assert world.neighbours_alive(3, 4) == 3
  end

  test "nextCalculationExample1" do
    world1 = World.new(0, 5, 8)
    world1.edit_cell_value(1, 4, true)
    world1.edit_cell_value(2, 5, true)
    world1.edit_cell_value(3, 3, true)
    world1.edit_cell_value(3, 4, true)
    world1.edit_cell_value(3, 5, true)
    world1 = world1.next

    world2 = World.new(1, 5, 8)
    world2.edit_cell_value(2, 3, true)
    world2.edit_cell_value(2, 5, true)
    world2.edit_cell_value(3, 4, true)
    world2.edit_cell_value(3, 5, true)
    world2.edit_cell_value(4, 4, true)

    assert world1 == world2
  end

  test "nextCalculationExample2" do
    world1 = World.new(0, 5, 8)
    world1.edit_cell_value(1, 4, true)
    world1.edit_cell_value(2, 5, true)
    world1.edit_cell_value(3, 3, true)
    world1.edit_cell_value(3, 4, true)
    world1.edit_cell_value(3, 5, true)
    world1 = world1.next
    world1 = world1.next

    world2 = World.new(2, 5, 8)
    world2.edit_cell_value(2, 5, true)
    world2.edit_cell_value(3, 3, true)
    world2.edit_cell_value(3, 5, true)
    world2.edit_cell_value(4, 4, true)
    world2.edit_cell_value(4, 5, true)

    assert world1 == world2
  end
end