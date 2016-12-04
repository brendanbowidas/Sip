defmodule Sip do
  @moduledoc """
  
    Welcome to Sip! ☕️

    Options:
    --deploy - deploy to environment
    --create - create a new machine
    --help - display this message
  """

  def main(args) do
    args
    |> parse_args
    |> process
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [deploy: :string,
                 create: :string,
                 verbose: :boolean,
                 help: :boolean ]
    )
    options
  end

  def process([]) do
    IO.puts @moduledoc
  end

  def process(options) do
    case options do
      [deploy: _env] -> Sip.Deploy.deploy(options)
      [create: _machine_name, verbose: _v] -> Sip.Ops.spawn_local_machine(options)
      [help: true] -> process([])
    end
  end
end
