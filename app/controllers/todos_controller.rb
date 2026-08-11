class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: %i[update destroy]

  def index
    @todos = current_user.todos.order(created_at: :desc)
    @todos = @todos.search_by_title(params[:search]) if params[:search].present?
    @todo = Todo.new
  end

  def create
    @todo = current_user.todos.build(todo_params)

    if @todo.save
      redirect_to todos_path, notice: "To do was successfully added."
    else
      @todos = current_user.todos.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @todo.update(completed: !@todo.completed)
    redirect_to todos_path
  end

  def destroy
    @todo.destroy
    redirect_to todos_path, notice: "To do was successfully removed."
  end

  private

  def set_todo
    @todo = current_user.todos.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title)
  end
end
