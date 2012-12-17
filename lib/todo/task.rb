module Todo
  class Task
    attr_reader :name, :created_date, :completed_date
    attr_writer :completed_date

    def initialize(name, created_date, completed_date=nil)
      @name = name
      @created_date = created_date
      @completed_date = completed_date
    end

    def completed?
      !completed_date.nil?
    end

    def completed
      @completed_date = Time.now
      self
    end

    def write_to_file(file)
      file.puts("#{name},#{created_date},#{completed_date}")
    end

    def self.create_from_file(filename)
      tasks = [] 
      File.open(filename, 'r') do |file|
        file.readlines.each do |line|
          name,created,completed = line.chomp.split(/,/)
          tasks << Task.new(name,created,completed)
        end
      end
      tasks
    end

  end
end
