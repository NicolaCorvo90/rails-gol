require "test_helper"

class GolFileHelperTest < ActionView::TestCase

  test "extractLinesFromEmptyString" do
    exceptionMessage = ""
    begin
      extractLinesFromString("")
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "extractLinesFromOneLineString" do
    exceptionMessage = ""
    begin
      extractLinesFromString("testLine")
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "extractLinesFromValidString" do
    example = "........
....*...
...**...
........"
    solution = %w[........ ....*... ...**... ........]
    result = extractLinesFromString(example)

    assert solution - result == []
  end

  test "extractGenerationFromEmptyString" do
    exceptionMessage = ""
    begin
      extractGenerationFromString("")
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "extractGenerationFromValidString" do
    example = "Generation 3:\n"
    solution = 3
    result = extractGenerationFromString(example)

    assert result == solution
  end

  test "extractRowsColsFromEmptyString" do
    exceptionMessage = ""
    begin
      extractRowsColsFromString("")
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "extractRowsFromValidString" do
    example = "4 8\n"
    solution = 4
    result = extractRowsColsFromString(example)

    assert result == solution
  end

  test "extractColsFromValidString" do
    example = "4 8\n"
    solution = 8
    result = extractRowsColsFromString(example, true)

    assert result == solution
  end

  test "createWorldWithWrongGeneration" do
    exceptionMessage = ""
    lines = %w[........ ....*... ...**... ........]
    begin
      createWorld(-1, 4, 8, lines)
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end
end
