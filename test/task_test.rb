require 'minitest/autorun'
# Let's have pretty test reports: https://github.com/CapnKernul/minitest-reporters
require 'minitest/reporters'
MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new
require_relative '../lib/todo/task'

describe Todo::Task do
  before do
    @task = Todo::Task.new('Task one', Time.now)
  end
  
  it 'starts out uncompleted' do
    @task.completed?.must_equal false
  end

  it 'can be marked as completed by providing a completion date' do
    @task.completed_date = Time.now
    @task.completed?.must_equal true
  end

  it "can be read from a file" do
    skip('need to mock file system')
  end
end
