defmodule Sip do
  @moduledoc """
    Options:
    --ops - deploy to environment, etc
    --help - display this message
  """

  def main(args) do
    args
    |> parse_args
    |> process
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [ ops: :boolean,
                 root: :boolean,
                 help: :boolean ]
    )
    options
  end

  def process([]) do
    IO.puts @moduledoc
  end

  def process(options) do
    case options do
      [ops: true, deploy: _env] -> Sip.Deploy.deploy(options)
      [root: true] -> Sip.Config.find_root
      [help: true] -> process([])
    end
  end
end
