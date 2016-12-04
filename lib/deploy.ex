defmodule Sip.Deploy do
  @root_dir Sip.Config.find_root
  @config @root_dir |> Sip.Config.get_config

  def deploy([deploy: env]) do
    env
    |> deploy_to_environment
  end

  defp deploy_to_environment(env) do
    config = is_valid(@config)
    root = is_valid(@root_dir)
    master_compose = Path.join(root, "/config/docker-compose.yml")
    frontend_dir = Path.join(root, "project/frontend")

    case Map.has_key?(config, env) do
      true -> machine_name = Map.get(config, env)
      false -> exit("Environment '#{env}' is not configured.")
    end

  end

  defp is_valid(config) do
    case config do
      {:ok, data} -> data
      {:error, msg} -> exit(msg)
    end
  end
end
