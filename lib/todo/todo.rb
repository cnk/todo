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

  def list_tasks(filename, format)
    begin
      File.open(filename, 'r') do |file|
        counter = 1
        file.readlines.each do |line|
          format == 'pretty'? display_todo(line, counter) : machine_readable_todo(line, counter)
          counter += 1
        end
      end
    rescue SystemCallError => err
      raise RuntimeError, "Couldn't open #{filename} for reading: #{err.message}"
    end
  end

  def complete_task(infile, outfile, completed_item)
    begin
    File.open(infile, 'r') do |infile|
      File.open(outfile, 'w') do |outfile|
        counter = 1
        infile.readlines.each do |line|
          if completed_item == counter
            # Write out existing data plus completion time
            name, created, completed = read_todo(line)
            write_todo(outfile, name, created, Time.now)
          else
            # Just copy the existing data to the new file
            write_todo(outfile, *read_todo(line))
          end
          counter += 1
        end
      end
    end
    rescue SystemCallError => err
      raise RuntimeError, "Couldn't open #{filename} for reading: #{err.message}"
    end

  end
    


  ########## helper methods for list_tasks #########

  def display_todo(line, counter)
    name, created, completed = read_todo(line)
    printf("%3d - %s\n", counter,name) 
    printf("      Created:   #{created} \n")
    unless completed.nil?
      printf ("      Completed: #{completed}\n")
    end
  end
  
  def machine_readable_todo(line, counter)
    name, created, completed = read_todo(line)
    completed_flag = completed ? "C" : "U"
    printf("%d,%s,%s,%s,%s\n",counter,name,completed_flag,created,completed)
  end
  
  def read_todo(line)
    line.chomp.split(',')
  end

end
