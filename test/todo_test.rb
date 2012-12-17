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
      @fake_file = StringIO.new("Completed task,2012-12-12 18:10:00 -0800,2012-12-12 22:50:00 -0800\nUncompleted task,2012-12-12 18:12:00 -0800,")
      File.stubs(:open).yields(@fake_file)
    end

    it "should generate machine-readable output if asked" do
      exp = "1,Completed task,C,2012-12-12 18:10:00 -0800,2012-12-12 22:50:00 -0800\n2,Uncompleted task,U,2012-12-12 18:12:00 -0800,"
      lambda {list_tasks("file.txt", Todo::Format::CSV.new)}.must_output exp
    end

    def teardown 
      File.unstub(:open)
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

