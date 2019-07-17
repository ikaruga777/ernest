require 'json'
require 'set'
def load(file)
  open(file) do |f|
    JSON.load(f)
  end
end
prev = load(ARGV[0])
current = load(ARGV[1])
prev_set = Set.new prev["emoji"].keys
current_set = Set.new current["emoji"].keys
puts "prev count#{prev_set.count}"
puts "current count #{current_set.count}"
diff = current_set - prev_set
puts "diff count #{diff.count}"
puts ":"+diff.to_a.join(': :')+":"
