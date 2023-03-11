require "test_helper"

class GolHelperTest < ActionView::TestCase
  test "worldJsonToWorldWithWrongJSON" do
    exceptionMessage = ""
    begin
      worldJsonToWorld("test123")
    rescue => e
      exceptionMessage = e.message
    end

    assert_not exceptionMessage.empty?
  end

  test "worldJsonToWorldWithRightJSON" do
    world1 = World.new(0, 5, 8)

    world2 = worldJsonToWorld(JSON.parse(world1.to_json))

    assert world1 == world2
  end
end