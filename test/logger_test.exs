defmodule ExLogger.LoggerTest do
  use ExUnit.Case
  doctest ExLogger

  test "formatting data, utc" do
    ts = {{2001, 1, 2}, {3, 4, 5, 6}}

    :ok = Application.put_env(:logger, :utc_log, true)
    json = ExLogger.format(:info, "hello world", ts, [])

    assert Jason.decode!(json) == %{
             "ts" => "2001-01-02T03:04:05.006Z",
             "msg" => "hello world",
             "level" => "info"
           }
  end

  test "formatting data, local time" do
    ts = {{2001, 1, 2}, {3, 4, 5, 6}}

    local_zone =
      System.cmd("date", ["+%z"])
      |> Tuple.to_list()
      |> Enum.at(0)
      |> String.split()
      |> Enum.at(0)
      |> String.to_charlist()
      |> Enum.split(3)
      |> Tuple.to_list()
      |> Enum.join(":")

    :ok = Application.put_env(:logger, :utc_log, false)
    json = ExLogger.format(:info, "hello world", ts, [])

    assert Jason.decode!(json) == %{
             "ts" => "2001-01-02T03:04:05.006#{local_zone}",
             "msg" => "hello world",
             "level" => "info"
           }
  end
end
