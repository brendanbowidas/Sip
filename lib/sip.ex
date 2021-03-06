defmodule Sip do
  @moduledoc """

    Welcome to Sip! ☕️

    Options:
    --deploy - deploy to environment
    --create - create a new machine
    -- start - start a local machine
    --help - display this message
  """

  def main(args) do
    args
    |> parse_args
    |> check_verbose
  end


  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [deploy: :string,
                 create: :string,
                 start: :string,
                 stop: :string,
                 verbose: :boolean,
                 project: :string,
                 help: :boolean ],
      aliases: [start: :start,
                stop: :stop,
                v: :verbose,
                d: :deploy,
                p: :project,
                h: :help]
    )
    options
  end


  def process([]) do
    IO.puts @moduledoc
  end


  def process(options) do

    case options do
      [verbose: _v, project: _proj, deploy: _env] -> Sip.Deploy.deploy(options)
      [verbose: _v, start: _machine_name] -> Sip.Ops.start_local_machine(options)
      [verbose: _v, stop: _machine_name] -> Sip.Ops.stop_local_machine(options)
      [verbose: _v, create: _machine_name] -> Sip.Ops.spawn_local_machine(options)
      [help: true] -> process([])
      [verbose: false] -> process([])
      [_, _] -> IO.puts "🚫  Unknown command! Run 'sip --help' for available options"
    end

  end


  defp check_verbose(options) do
    cond do
      Keyword.has_key?(options, :verbose) ->
        process(options)
      true ->
         Keyword.put_new(options, :verbose, false)
         |> process
    end
  end

end
