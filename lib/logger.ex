defmodule ExLogger do
  def format(level, message, timestamp, metadata) do
    time = case Timex.format(timestamp, "{ISO:Extended:Z}") do
      {:ok, time_str} -> time_str
      _ -> Timex.format!(Timex.now, "{ISO:Extended:Z}")
    end
    try do
      log_data = Map.merge(%{
        "msg" => "#{message}",
        "level" => level,
        "ts" => time
      }, Map.new(metadata))

      "#{Poison.encode!(log_data)}\n"
    rescue
      _ -> "#{time} #{metadata[level]} #{level} #{message}\n"
    end
  end
end
