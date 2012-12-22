require 'terminal-table'

module Todo
  module Format
    class Tabular
      def before
        @@table = Terminal::Table.new headings: %w(Id Name Created Completed)
        @@table.align_column(0, :right)
      end

      def format(counter, task, destination)
        row = []
        row << counter
        row << task.name
        row << as_date(task.created_date)
        row << as_date(task.completed_date)
        @@table << row
      end

      def after(destination)
        destination.puts @@table.to_s
      end

      def as_date(str)
        str ? DateTime.parse(str).strftime("%Y-%m-%d") : ''
      end

    end
  end
end
