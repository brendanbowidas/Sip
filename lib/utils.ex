defmodule Sip.Utils do

  def run_command(cmd, verbose) do
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

  def set_env(machine_name) do
    {res, _} =  System.cmd "docker-machine", ["env", machine_name]
    
    res
    |> format_env_vars
    |> System.put_env
  end

  @doc """
    Format string from "docker-machine env" command into a
    list of key-value tuples
  """
  defp format_env_vars(env_vars) do
    env_vars
    |> String.replace("export", "")
    |> String.replace("\n", "")
    |> String.replace("#", "")
    |> KeyValueParser.parse
    |> Enum.filter(&is_docker_var/1)
    |> Enum.map(fn({k, v}) ->
       {Atom.to_string(k), v}
     end)
  end

# Filter out keys that don't begin with "DOCKER"
  defp is_docker_var({key, _val}) do
    key
    |> Atom.to_string
    |> String.starts_with?("DOCKER")
  end

end
