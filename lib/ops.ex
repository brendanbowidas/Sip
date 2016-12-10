defmodule Sip.Ops do

  def spawn_local_machine([create: name, verbose: verbose]) do
    "docker-machine create -d virtualbox #{name}"
    |> Sip.Utils.run_command(verbose)
  end

  def start_local_machine([verbose: verbose, start: name]) do
    machine_cmd("start", name, verbose)
  end

  def stop_local_machine([verbose: verbose, stop: name]) do
    machine_cmd("stop", name, verbose)
  end

  defp machine_cmd(cmd, name, verbose) do
    "docker-machine #{cmd} #{name}"
    |> Sip.Utils.run_command(verbose)
  end
end
