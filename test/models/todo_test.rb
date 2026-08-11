require "test_helper"

class TodoTest < ActiveSupport::TestCase
  test "valid with a title and a user" do
    todo = Todo.new(title: "Buy milk", user: users(:one))
    assert todo.valid?
  end

  test "invalid without a title" do
    todo = Todo.new(title: nil, user: users(:one))
    assert_not todo.valid?
  end

  test "invalid without a user" do
    todo = Todo.new(title: "Buy milk")
    assert_not todo.valid?
  end

  test "defaults to not completed" do
    todo = Todo.create!(title: "Buy milk", user: users(:one))
    assert_not todo.completed?
  end

  test "search_by_title returns todos whose title contains the search text" do
    assert_includes Todo.search_by_title("groceries"), todos(:one)
  end

  test "search_by_title is case-insensitive" do
    assert_includes Todo.search_by_title("GROCERIES"), todos(:one)
  end

  test "search_by_title excludes todos that do not match" do
    assert_not_includes Todo.search_by_title("groceries"), todos(:two)
  end
end
