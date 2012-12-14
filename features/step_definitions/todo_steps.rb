When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end

Given /^the file "(.*?)" doesn't exist$/ do |filename|
  FileUtils.rm(filename) if File.exists?(filename)
end

Given /^there is no task list in my home directory$/ do
  step %(the file "#{ENV['HOME']}/todo.txt" doesn't exist)
end

Then /^the task list should exist in my home directory$/ do
  step %(a file named "#{ENV['HOME']}/todo.txt" should exist)
end
