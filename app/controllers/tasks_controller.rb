class TasksController < ApplicationController

    def index
        @tasks = Task.all
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.create(task_params)
    end

    def edit
        @task = Task.find(params[:id])
    end

    def update
        @task = Task.find(params[:id])
        @task.update! (task_params)
        redirect_to @task
    end

    def show
        @task = Task.find(params[:id])
    end

    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        redirect_to tasks_path, notice: 'Task was deleted successfully'
      end

    private

    def task_params
        params.require(:task).permit(:todo, :due, :notes)
    end
end