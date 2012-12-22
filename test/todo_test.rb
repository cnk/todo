require 'minitest/autorun'
# Let's have pretty test reports: https://github.com/CapnKernul/minitest-reporters
require 'minitest/reporters'
MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new
$LOAD_PATH.push File.expand_path("../../lib", __FILE__)
require 'todo'
include Todo

# Some test setup
require 'mocha/setup'
require 'stringio'

describe "Todo actions" do
  describe "list" do
    before do
      @output = StringIO.new
      @file = File.expand_path(File.dirname(__FILE__) + '/assets/todo.txt')
    end

    it "should generate machine-readable output if asked" do
      expected = "1,Finished Task 1,C,2012-12-12 18:10:25 -0800,2012-12-12 22:52:32 -0800\n2,Unfinished Task 1,U,2012-12-12 18:25:06 -0800,\n"
      list_tasks(@file, Todo::Format::CSV.new, @output)
      assert_equal expected, @output.string
    end

    it "should generate human-readable output if asked" do
        expected = "  1 - Finished Task 1
      Created:   2012-12-12 18:10:25 -0800
      Completed: 2012-12-12 22:52:32 -0800
  2 - Unfinished Task 1
      Created:   2012-12-12 18:25:06 -0800
"
      # Don't use ANSI colors in this test
      Sickill::Rainbow.enabled = false
      list_tasks(@file, Todo::Format::Pretty.new, @output)
      assert_equal expected, @output.string
    end
  end

  describe "done" do
    # "This is a bigger job to test because of the 2 files."
  end

  describe "new" do
    it " should raise an error when there are no tasks" do
      File.stubs(:open).yields(StringIO.new)
      err = lambda {new_task('problems.txt', [])}.must_raise RuntimeError
      err.message.must_match "You must provide tasks on the command-line or from standard input"
    end
    
    it "should add tasks to the task list" do
      fake_file = StringIO.new
      File.stubs(:open).yields(fake_file)
      new_task('todo-list.txt', ["Test task"])
    assert_match /^Test task,/, fake_file.string
    end

    it "should tell you if it can't open the file" do
      ex_msg = "Operation not permitted"
      File.stubs(:open).raises(Errno::EPERM.new(ex_msg))
      ex = assert_raises RuntimeError do
        new_task("foo.txt",["This is a task"])
      end
      assert_match /^Couldn't open foo.txt for appending: #{ex_msg}/, ex.message
    end

    def teardown 
      File.unstub(:open)
    end
  end
  
end

