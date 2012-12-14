module Todo
  def new_task(filename, task_names)
    File.open(filename, 'a+') do |todo_file|
      tasks = 0
      task_names.each do |task|
        todo_file.puts [task, Time.now].join(',')
        tasks += 1
      end
      if tasks == 0
        raise "You must provide tasks on the command-line or from standard input"
      end
    end
  end
end
