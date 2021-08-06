require 'rails_helper'

RSpec.describe "ViewTasks", type: :system do
  before do
    driven_by(:rack_test)
  end

  # before :all do
  #   @task = Task.create(todo:'sample todo', due:'2021-08-05 21:58:00 UTC', notes: 'sample notes' )
  # end

describe 'index view' do
  it 'display all tasks' do
    visit tasks_path

    within 'tbody' do
    expect(page).to have_selector('tr', count: 1)
    end
  end

  it 'loads the edit view when edit button is clicked' do
    visit tasks_path
    within 'tbody' do
      find_link('Edit').click
    end
    expect(page).to have_current_path(edit_task_path(task))
    expect(find_field('Name').value).to eq task.name
  end

  it 'loads the show view when the show buttin is clicked' do
    visit tasks_path
    within 'tbody' do
      find_link('Show').click
    end
    expect(page).to have_current_path(task_path(task))
    expect(page).to have_content(task.name.capitalize)
  end

  it 'destroys task when the delete button is clicked' do
    visit tasks_path
    expect do 
      accept_alert 'Are you sure?' do
        within 'tbody' do
          click_link('Delete')
        end
      end
      expect(page).to have_current_path(tasks_path)
  end.to change(Task, :count).by(-1)
  expect(page).to have_content('Category was deleted successfully')
end


end

end
