defmodule ExLogger.TimestampFormatterTest do
  use ExUnit.Case

  alias ExLogger.Formatter.Timestamp

  test "test format timestamp" do
    ts = {{2001, 1, 2}, {3, 4, 5, 6}}

    assert Timestamp.format(ts, {0, 0}) == "2001-01-02T03:04:05.006Z"
    assert Timestamp.format(ts, {5, 0}) == "2001-01-02T03:04:05.006+05:00"
    assert Timestamp.format(ts, {15, 0}) == "2001-01-02T03:04:05.006+15:00"
    assert Timestamp.format(ts, {5, 30}) == "2001-01-02T03:04:05.006+05:30"
    assert Timestamp.format(ts, {-5, 0}) == "2001-01-02T03:04:05.006-05:00"
    assert Timestamp.format(ts, {-15, 0}) == "2001-01-02T03:04:05.006-15:00"
    assert Timestamp.format(ts, {-5, -30}) == "2001-01-02T03:04:05.006-05:30"
  end

  test "format 0 offset" do
    assert Timestamp.format_offset({0, 0}) == "Z"
  end

  test "format positive offset" do
    assert Timestamp.format_offset({1, 0}) == "+01:00"
    assert Timestamp.format_offset({0, 30}) == "+00:30"
    assert Timestamp.format_offset({10, 30}) == "+10:30"
  end

  test "format negative offset" do
    assert Timestamp.format_offset({-1, 0}) == "-01:00"
    assert Timestamp.format_offset({0, -30}) == "-00:30"
    assert Timestamp.format_offset({-10, -30}) == "-10:30"
  end

  test "positive offset" do
    utc = {{2019, 3, 8}, {15, 24, 36}}
    local = {{2019, 3, 8}, {16, 54, 36}}

    assert Timestamp.offset(utc, local) == {1, 30}
  end

  test "negative offset" do
    utc = {{2019, 3, 8}, {16, 54, 36}}
    local = {{2019, 3, 8}, {15, 24, 36}}

    assert Timestamp.offset(utc, local) == {-1, -30}
  end

  test "positive date spanning offset" do
    utc = {{2019, 3, 8}, {23, 54, 36}}
    local = {{2019, 3, 9}, {01, 24, 36}}

    assert Timestamp.offset(utc, local) == {1, 30}
  end

  test "positive date spanning offset hour only" do
    utc = {{2019, 3, 8}, {23, 54, 36}}
    local = {{2019, 3, 9}, {01, 54, 36}}

    assert Timestamp.offset(utc, local) == {2, 0}
  end

  test "negative date spanning offset" do
    utc = {{2019, 3, 9}, {01, 24, 36}}
    local = {{2019, 3, 8}, {23, 55, 36}}

    assert Timestamp.offset(utc, local) == {-1, -29}
  end

  test "negative date spanning offset hour only" do
    utc = {{2019, 3, 9}, {01, 24, 36}}
    local = {{2019, 3, 8}, {23, 24, 36}}

    assert Timestamp.offset(utc, local) == {-2, 0}
  end
end
