require 'aruba/cucumber'

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','lib')

Before do
  # Using "announce" causes massive warnings on 1.9.2
  @puts = true
  
# Set the RUBYLIB var so we can access todo's lib directory even if we are not running todo from a gem
  @original_rubylib = ENV['RUBYLIB']
  ENV['RUBYLIB'] = LIB_DIR + File::PATH_SEPARATOR + ENV['RUBYLIB'].to_s

  # Set up a fake home directory so we can test todo runs without specifying the file location
  @real_home = ENV['HOME']
  fake_home = File.join('/tmp','fake_home') 
  FileUtils.rm_rf fake_home, :secure => true 
  Dir.mkdir fake_home
  ENV['HOME'] = fake_home
end

After do
  # reset the RUBYLIB directory to it's previous value
  ENV['RUBYLIB'] = @original_rubylib
  ENV['HOME'] = @real_home
end
