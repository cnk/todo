require 'minitest/autorun'
# Let's have pretty test reports: https://github.com/CapnKernul/minitest-reporters
require 'minitest/reporters'
MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new
require_relative '../lib/todo/todo'
include Todo

# Some test setup shanaegens
require 'mocha/setup'
require 'stringio'

describe "Todo actions" do
  it "should raise an error when there are no tasks" do
    err = lambda {Todo.new_task('todo.txt', [])}.must_raise RuntimeError
    err.message.must_match "You must provide tasks on the command-line or from standard input"
  end

  it "should add tasks to the task list" do
    fake_file = StringIO.new
    File.stubs(:open).yields(fake_file)
    new_task('todo-list.txt', ["Test task"])
    assert_match /^Test task,/, fake_file.string
  end

end

