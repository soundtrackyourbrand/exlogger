defmodule ExLogger do
  def format(level, message, timestamp, metadata) do
    try do
      time = case Timex.format(timestamp, "{ISO:Extended:Z}") do
        {:ok, time_str} -> time_str
        _ -> Timex.format!(Timex.now, "{ISO:Extended:Z}")
      end
      log_data = Map.merge(%{
        "msg" => message,
        "level" => level,
        "ts" => time
      }, Map.new(metadata))

      "#{Poison.encode!(log_data)}\n"
    rescue
      _ -> "#{timestamp} #{metadata[level]} #{level} #{message}\n"
    end
  end
end
