module Todo
  module Format
    class Pretty
      def format(counter, task)
        printf("%3d - %s\n", counter,task.name) 
        printf("      Created:   #{task.created_date} \n")
        if task.completed?
          printf ("      Completed: #{task.completed_date}\n")
        end
      end
    end
  end
end
