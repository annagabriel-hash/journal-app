class TasksController < ApplicationController
    before_action :set_task, only: %i[ show edit update destroy]

    def index
        @tasks = Task.all
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.create(task_params)
        redirect_to @task
    end

    def edit
    end

    def update
        @task.update! (task_params)
        redirect_to @task
    end

    def show
    end

    def destroy
        @task.destroy
        redirect_to tasks_path, notice: 'Task was deleted successfully'
      end

    private

    def set_task
        @task = Task.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:todo, :due, :notes)
    end
end