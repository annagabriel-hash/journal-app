class TasksController < ApplicationController
    def new
        @task = Task.new
    end

    def create
        @task = Task.create(task_params)
    end

    private

    def task_params
        params.require(:task).permit(:todo, :due, :notes)
    end
end