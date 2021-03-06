module Todo
  def new_task(filename, task_names)
    begin
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
    rescue SystemCallError => err
      raise RuntimeError, "Couldn't open #{filename} for appending: #{err.message}"
    end
  end

  def list_tasks(filename, formatter, destination=STDOUT)
    begin
      File.open(filename, 'r') do |file|
        formatter.before
        counter = 1
        Task.create_from_file(file).each do |task|
          formatter.format(counter, task, destination)
          counter += 1
        end
        formatter.after(destination)
      end
    rescue SystemCallError => err
      raise RuntimeError, "Couldn't open #{filename} for reading: #{err.message}"
    end
  end

  def complete_task(filename, completed_item)
    infile = filename
    outfile = filename + '.NEW'
    begin
      File.open(infile, 'r') do |infile|
        File.open(outfile, 'w') do |outfile|
          counter = 1
          Todo::Task.create_from_file(infile).each do |task|
            if completed_item == counter
              task.completed_date = Time.now
            end
            task.write_to_file(outfile)
            counter += 1
          end
        end
      end
    FileUtils.mv(outfile, infile)
    rescue SystemCallError => err
      raise RuntimeError, "Couldn't open #{filename} to update it: #{err.message}"
    end
  end
    
end
