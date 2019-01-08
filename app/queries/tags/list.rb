module Tags
  class List
    def initialize()
    end

    def perform
      Tag.all
    end
  end
end
