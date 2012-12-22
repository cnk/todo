require 'rainbow'

module Todo
  module Format
    class Pretty
      def format(counter, task, destination)
        color = task.completed? ? :green : :default
        destination.puts sprintf("%3d - %s", counter,task.name.bright).color(color)
        destination.puts sprintf("      Created:   #{task.created_date}").color(color)
        if task.completed?
          destination.puts sprintf ("      Completed: #{task.completed_date}").color(color)
        end
      end

      def before; end
      def after(destination); end
    end
  end
end
