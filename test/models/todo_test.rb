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
end
