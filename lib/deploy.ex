defmodule Sip.Deploy do
  @config Sip.Config.find_root

  def deploy([deploy: env]) do
    env
    |> deploy_to_environment
  end

  defp deploy_to_environment(env) do
    config = check_config(@config)
    case Map.has_key?(config, env) do
      true -> IO.inspect Map.get(config, env)
      false -> exit("Environment '#{env}' is not configured.")
    end
  end

  defp check_config(config) do
    case config do
      {:ok, data} -> data
      {:error, msg} -> exit(msg)
    end
  end
end
