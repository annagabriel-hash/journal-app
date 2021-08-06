class TasksController < ApplicationController
    before_action :get_user
    before_action :set_task, only: %i[show edit update destroy]

    def index
        @tasks = Task.all
    end

    def new
        @task = @user.tasks.build
    end

    def create
        @task = @user.tasks.build(task_params)
        if @task.save
            redirect_to [@user, @task], notice: 'Task was created successfully'
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @task.update(task_params)
            redirect_to [@user, @task], notice: 'Task was updated successfully'
        else
            render :edit
        end
    end

    def show
    end

    def destroy
        @task.destroy
        redirect_to tasks_path, notice: 'Task was deleted successfully'
      end

    private

    def get_user 
        @user = User.find(params[:user_id])
    end

    def set_task
        @task = Task.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:todo, :due, :notes, :category_id, :user_id)
    end
end