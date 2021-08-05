require 'rails_helper'

RSpec.describe "CreateTasks", type: :system do
  let(:date) { DateTime.new(2021, 8, 4, 18, 24, 0)}
  before do
    driven_by(:rack_test)
  end

  it 'saves and display task' do
    visit '/tasks/new'
    fill_in 'Todo', with: 'sample task'
    fill_in 'Due', with: date.strftime("%FT%R")
    fill_in 'Notes', with: 'sample notes'
    expect { click_on 'Submit task' }.to change(Task, :count).by(1)

    expect(page).to have_content('sample task')
    expect(page).to have_content(date.strftime("%F %T UTC"))
    expect(page).to have_content('sample notes')

    task = Task.order("id").last
    expect(task.todo).to eq('sample task')
    expect(task.due).to eq(date)
    expect(task.notes).to eq('sample notes')


  end

  pending "add some scenarios (or delete) #{__FILE__}"
end
