defmodule Sip.Utils do

  def run_command(cmd, verbose \\ false) do
       cmd
        |>String.split
        |> execute(verbose)
  end

  defp execute([root | args], verbose) do
    case verbose do
      true ->
        System.cmd root, args, into: IO.stream(:stdio, :line)
      false ->
        System.cmd root, args
    end
  end

end