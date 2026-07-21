# Monkey-patch for Cucumber 10.2.0 bug where group.children is nil
# in message_builder.rb#argument_group_to_message, causing:
#   undefined method 'map' for nil (NoMethodError)
# This affects --publish, --format html, and --format message.
# Remove this file when upgrading to a Cucumber version that fixes:
# https://github.com/cucumber/cucumber-ruby/issues/1802
require 'cucumber/formatter/message_builder'

module Cucumber
  module Formatter
    class MessageBuilder
      private

      def argument_group_to_message(group)
        Cucumber::Messages::Group.new(
          start: group.start,
          value: group.value,
          children: (group.children || []).map { |child| argument_group_to_message(child) }
        )
      end
    end
  end
end
