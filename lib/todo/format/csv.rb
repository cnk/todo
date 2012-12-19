module Todo
  module Format
    class CSV
      def format(counter, task, destination)
        completed_flag = task.completed? ? "C" : "U"
        destination.puts sprintf("%d,%s,%s,%s,%s\n",counter,task.name,completed_flag,task.created_date,task.completed_date)
      end
    end
  end
end
