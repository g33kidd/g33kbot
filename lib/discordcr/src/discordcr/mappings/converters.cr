require "json"
require "time/format"

module Discord
  DATE_FORMAT = Time::Format.new("%FT%T.%L%:z")

  # :nodoc:
  module EmbedTimestampConverter
    SEND_FORMAT    = Time::Format.new("%FT%T%:z")
    RECEIVE_FORMAT = Time::Format.new("%FT%TZ")

    def self.from_json(parser : JSON::PullParser) : Time
      SEND_FORMAT.from_json(parser)
    end

    def self.to_json(value : Time, builder : JSON::Builder)
      RECEIVE_FORMAT.to_json(value.to_utc, builder)
    end
  end

  # :nodoc:
  module SnowflakeConverter
    def self.from_json(parser : JSON::PullParser) : UInt64
      parser.read_string.to_u64
    end

    def self.to_json(value : UInt64, builder : JSON::Builder)
      builder.scalar(value.to_s)
    end
  end

  # :nodoc:
  module MaybeSnowflakeConverter
    def self.from_json(parser : JSON::PullParser) : UInt64?
      str = parser.read_string_or_null

      if str
        str.to_u64
      else
        nil
      end
    end

    def self.to_json(value : UInt64?, builder : JSON::Builder)
      if value
        builder.scalar(value.to_s)
      else
        builder.null
      end
    end
  end

  # :nodoc:
  module SnowflakeArrayConverter
    def self.from_json(parser : JSON::PullParser) : Array(UInt64)
      Array(String).new(parser).map &.to_u64
    end

    def self.to_json(value : Array(UInt64), builder : JSON::Builder)
      value.map(&.to_s).to_json(builder)
    end
  end
end
