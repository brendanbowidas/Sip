defmodule Sip.Utils do

  def run_command(cmd, verbose \\ false) do
       cmd
        |>String.split
        |> isolate_args
        |> execute
  end

  defp isolate_args([head | tail ]) do
    [head, tail]
  end

  defp execute([root | [args]]) do
    System.cmd root, args, into: IO.stream(:stdio, :line)
  end

end
