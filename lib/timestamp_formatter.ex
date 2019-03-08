defmodule ExLogger.Formatter.Timestamp do
  @spec utc_offset(boolean) :: {-23..23, -59..59}
  def utc_offset(true), do: {0, 0}

  def utc_offset(false) do
    now = :os.timestamp()
    offset(:calendar.now_to_universal_time(now), :calendar.now_to_local_time(now))
  end

  @spec offset(Logger.Formatter.time(), Logger.Formatter.time()) :: {-23..23, -59..59}
  def offset(utc, local) do
    case :calendar.time_difference(utc, local) do
      {0, {h, m, _}} -> {h, m}
      {-1, {h, 0, _}} -> {h - 24, 0}
      {-1, {h, m, _}} -> {h - 23, m - 60}
    end
  end

  @spec format(Logger.Formatter.time(), {integer, integer}) :: String.t()
  def format({date, time}, utc_offset) do
    date =
      date
      |> Logger.Formatter.format_date()
      |> List.to_string()

    time =
      time
      |> Logger.Formatter.format_time()
      |> List.to_string()

    timezone = format_offset(utc_offset)

    "#{date}T#{time}#{timezone}"
  end

  @spec format_offset({integer, integer}) :: String.t()
  def format_offset({0, 0}), do: "Z"
  def format_offset({h, m}) when h > 0 or m > 0, do: "+#{pad(h)}:#{pad(m)}"
  def format_offset({h, m}) when h < 0 or m < 0, do: "-#{pad(abs(h))}:#{pad(abs(m))}"

  @spec pad(integer) :: String.t()
  defp pad(int) when int < 10, do: "0#{int}"
  defp pad(int), do: "#{int}"
end
