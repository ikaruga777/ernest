# frozen_string_literal: true

class EmojiJson
  def initialize(prev_json, current_json)
    @prev_json = prev_json
    @current_json = current_json
  end

  def diff
    prev_emojis = Set.new @prev_json['emoji'].keys
    current_emojis = Set.new @current_json['emoji'].keys
    diff = current_emojis - prev_emojis
    format(prev_emojis, current_emojis, diff)
  end

  private

  def format(prev_emojis, current_emojis, diff)
    content = "prev count#{prev_emojis.count}\n"
    content << "current count #{current_emojis.count}\n"
    content << "diff count #{diff.count}\n"
    content << ':' + diff.to_a.join(': :') + ':' if diff.count > 0
    content
  end
end
