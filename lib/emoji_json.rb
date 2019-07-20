class EmojiJson
  def self.diff(prev_json,current_json)
    prev_set = Set.new prev["emoji"].keys
    current_set = Set.new current["emoji"].keys
    puts "prev count#{prev_set.count}"
    puts "current count #{current_set.count}"
    diff = current_set - prev_set
    puts "diff count #{diff.count}"
    puts ":"+diff.to_a.join(': :')+":"
  end
end
