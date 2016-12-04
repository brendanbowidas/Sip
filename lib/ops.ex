defmodule Sip.Ops do

  def spawn_local_machine([create: name, verbose: verbose]) do
    "docker-machine create -d virtualbox #{name}"
    |> Sip.Utils.run_command(verbose)
  end

end
