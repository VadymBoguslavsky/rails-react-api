class TodosController < ApplicationController
  before_action :set_todo, only: [:update, :destroy]

  def index
    @todos = current_user.todos.order(priority: :desc)

    render json: @todos
  end

  def show
    render json: @todo
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      render json: @todo, status: :created, location: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def sort
    todos = current_user.todos.order( params[:sortByTitle] + " " + params[:sortByAsc] )

    if todos
      render json: todos, status: 200
    else
      head(:bad_request)
    end
  end

  def destroy
    @todo.destroy
  end

  private
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def todo_params
      params.require(:todo).permit(:id, :completed, :title, :description, :priority, :due_date, :user_id)
    end
end
