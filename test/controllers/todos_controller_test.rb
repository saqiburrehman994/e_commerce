require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @todo = todos(:one)
    sign_in @user
  end

  test "should redirect index when not signed in" do
    sign_out @user
    get todos_url
    assert_redirected_to new_user_session_path
  end

  test "should get index" do
    get todos_url
    assert_response :success
  end

  test "should only list the current user's todos" do
    get todos_url
    assert_no_match todos(:two).title, @response.body
  end

  test "should filter todos by search title" do
    get todos_url, params: { search: "groceries" }
    assert_match @todo.title, @response.body
  end

  test "should filter todos by search title case-insensitively" do
    get todos_url, params: { search: "GROCERIES" }
    assert_match @todo.title, @response.body
  end

  test "should not include todos that do not match search" do
    get todos_url, params: { search: "nonexistent" }
    assert_no_match @todo.title, @response.body
  end

  test "should list all todos when search is blank" do
    get todos_url, params: { search: "" }
    assert_match @todo.title, @response.body
  end

  test "should create todo" do
    assert_difference("@user.todos.count") do
      post todos_url, params: { todo: { title: "Buy milk" } }
    end

    assert_redirected_to todos_url
  end

  test "should not create todo without a title" do
    assert_no_difference("Todo.count") do
      post todos_url, params: { todo: { title: "" } }
    end
  end

  test "should toggle completed on update" do
    assert_changes -> { @todo.reload.completed }, from: false, to: true do
      patch todo_url(@todo)
    end

    assert_redirected_to todos_url
  end

  test "should not update another user's todo" do
    patch todo_url(todos(:two))
    assert_response :not_found
  end

  test "should destroy todo" do
    assert_difference("Todo.count", -1) do
      delete todo_url(@todo)
    end

    assert_redirected_to todos_url
  end
end
