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
    todo_file =  File.expand_path(File.dirname(__FILE__) + '/assets/todo.txt')
    tasks = Todo::Task.from_file(todo_file)
    tasks.kind_of?(Array).must_equal true
    tasks[0].kind_of?(Todo::Task).must_equal true
  end
end
