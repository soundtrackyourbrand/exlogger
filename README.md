# ExLogger

Used to standardize log format for elixir projects. Outputs logs in JSON format, e.g:
```
{
  "ts":"2018-02-13T09:43:11.000386Z",
  "msg":"Binding queue to: core.entity.update",
  "level":"info",
  "module":"Elixir.AMQP",
  "function":"bind_channel/4"
}
```

To enable exlogger you have to add this to your config:
```
config :logger, :console,
  format: {ExLogger, :format},
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `elixir_logger` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:exlogger, "~> 0.1.0"}
  ]
end
```
