defmodule ExLoggerTest do
  use ExUnit.Case
  doctest ExLogger

  test "greets the world" do
    timestamp = DateTime.utc_now
    json = ExLogger.format("info", "hello world!", timestamp, [])
    assert json != ""
    assert json == "{\"ts\":\"#{Timex.format!(timestamp, "{ISO:Extended:Z}")}\",\"msg\":\"hello world!\",\"level\":\"info\"}\n"
    parsed = Poison.decode!(json)
    assert Map.get(parsed, "msg") == "hello world!"
    assert Map.get(parsed, "level") == "info"
  end
end
