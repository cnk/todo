module Todo
  module Format
    class Pretty
      def format(counter, task, destination)
        destination.puts sprintf("%3d - %s\n", counter,task.name) 
        destination.puts sprintf("      Created:   #{task.created_date}\n")
        if task.completed?
          destination.puts sprintf ("      Completed: #{task.completed_date}\n")
        end
      end
    end
  end
end
