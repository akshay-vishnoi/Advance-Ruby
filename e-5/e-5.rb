firstString = String.new("New String 1")
secondString = String.new("New String 2")

class << firstString
  def go
    puts "start test"
  end
end

def firstString.stop
  puts "stop test"
end
firstString.go
firstString.stop
secondString.go
secondString.stop




