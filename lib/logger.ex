defmodule ExLogger do
  alias ExLogger.Formatter.Timestamp

  @spec format(
          Logger.level(),
          Logger.message(),
          Logger.Formatter.time(),
          Logger.Formatter.keyword()
        ) :: IO.chardata()
  def format(level, message, timestamp, metadata) do
    offset = Timestamp.utc_offset(Application.fetch_env!(:logger, :utc_log))
    time = Timestamp.format(timestamp, offset)

    log_data =
      Map.merge(
        %{
          "msg" => "#{message}",
          "level" => level,
          "ts" => time
        },
        Map.new(metadata)
      )

    "#{Poison.encode!(log_data)}\n"
  rescue
    _ ->
      "#{Timestamp.format(timestamp, {0, 0})} #{metadata[level]} #{level} #{message}\n"
  end
end
