require 'rails_helper'

RSpec.describe "ViewTasks", type: :system do
  let(:user) { User.create(username: 'janedoe', firstname: 'Jane', lastname: 'Doe', password: 'password', password_confirmation: 'password') }
  let(:date) { DateTime.new(2021, 8, 21, 18, 24, 0) }
  let!(:task) { Task.create(todo:'sample todo', due: date, notes: 'sample notes', user: user ) }
  
  def login(user)
    visit root_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Log In'
  end

  before do
    driven_by(:rack_test)
    login(user)
    visit user_tasks_path(user)
  end

describe 'index view' do
  it 'display all tasks' do
    user_task = user.tasks
    expect(user_task.count).to eq(1)
    within 'tbody' do
    expect(page).to have_selector('tr', count: 1)
    end
  end

  it 'loads the edit view when edit button is clicked' do
    within 'tbody' do
      find_link('Edit').click
    end
    expect(page).to have_current_path(edit_user_task_path(user, task))
    expect(find_field('Todo').value).to eq task.todo
    expect(find_field('Due').value).to eq task.due.strftime("%FT%T")
    expect(find_field('Notes').value).to eq task.notes
  end

  it 'loads the show view when the show button is clicked' do
    within 'tbody' do
      find_link('Show').click
    end
    expect(page).to have_current_path(user_task_path(user, task))
    expect(page).to have_content(task.todo)
    expect(page).to have_content(task.due)
    expect(page).to have_content(task.notes)
  end

  it 'destroys task when the delete button is clicked' do
    expect{ click_link('Delete') }.to change(Task, :count).by(-1)
  expect(page).to have_current_path(user_tasks_path(user))
  expect(page).to have_content('Task was deleted successfully')
end


end

end
