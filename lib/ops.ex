defmodule Sip.Ops do

  @config Sip.Config.find_root |> Sip.Config.get_config

  def spawn_local_machine([verbose: verbose, create: name]) do
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
    machine = check_config(name, @config)

    "docker-machine #{cmd} #{machine}"
    |> Sip.Utils.run_command(verbose)
  end


  defp check_config(env, {_ok, config}) do
    case Map.has_key?(config, env) do
      true ->
        Map.get(config, env)
      false ->
        env
    end
  end

end
