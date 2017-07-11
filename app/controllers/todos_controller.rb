class TodosController < ApplicationController
  before_action :set_todo, only: [:update, :destroy]

  # GET /todos
  def index
    @todos = current_user.todos.all

    render json: @todos
  end

  # GET /todos/1
  def show
    render json: @todo
  end

  # POST /todos
  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      render json: @todo, status: :created, location: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def sort
    @todos = todos.order( params[:sortByTitle] + " " + params[:sortByAsc] )

    if todos
      render json: todos, status: 200
    else
      head(:bad_request)
    end
  end

  # DELETE /todos/1
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
