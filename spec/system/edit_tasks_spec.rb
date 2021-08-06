require 'rails_helper'

RSpec.describe "EditTasks", type: :system do
  let(:user) {User.create(username: 'janedoe', firstname: 'Jane', lastname: 'Doe', password: 'password', password_confirmation: 'password')}
  let(:date) { DateTime.new(2021, 8, 8, 18, 24, 0)}
  let(:task) { Task.create(todo:'sample todo', due:date, notes: 'sample notes', user:user ) }

  def login(user)
    visit root_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Log In'
  end

  before do
    driven_by(:rack_test)
    login(user)
    visit edit_user_task_path(user, task)
  end

  it 'edits task' do
    fill_in 'Todo', with: 'Sample task. Edited!'
    fill_in 'Due', with: date.strftime("%FT%R")
    fill_in 'Notes', with: 'Sample notes. Edited!'
    click_on 'Submit task'

    expect(page).to have_content("Sample task. Edited!")
    expect(page).to have_content(date.strftime("%F %T UTC"))
    expect(page).to have_content("Sample notes. Edited")
  end
end
