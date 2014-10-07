class TodoItemsController < ApplicationController
  def index
  	@todo_list = TodoList.find(params[:todo_list_id])		# todo_list is an instance variable, we have access to it from view
  end
end
