require 'rails_helper'

RSpec.describe "EditTasks", type: :system do
  before do
    driven_by(:rack_test)
  end

  before :all do
    @task = Task.create(todo:'sample todo', due:'2021-08-05 21:58:00 UTC', notes: 'sample notes' )
  end

  it 'edits task' do
    visit "tasks/#{@task.id}/edit"
    fill_in 'Todo', with: 'Sample task. Edited!'
    fill_in 'Due', with: '2021-09-05 21:58:00 UTC'
    fill_in 'Notes', with: 'Sample notes. Edited!'
    click_on 'Submit task'

    expect(page).to have_content("Sample task. Edited!")
    expect(page).to have_content("2021-09-05 21:58:00 UTC")
    expect(page).to have_content("Sample notes. Edited")
  end
end
