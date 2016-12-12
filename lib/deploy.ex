defmodule Sip.Deploy do
  @root_dir Sip.Config.find_root
  @config @root_dir |> Sip.Config.get_config


  def deploy([verbose: verbose, deploy: env]) do
    env
    |> deploy_to_environment(verbose)
  end


  defp deploy_to_environment(env, verbose) do
    config = is_valid(@config)
    root = is_valid(@root_dir)
    master_compose = Path.join(root, "/config/docker-compose.yml")
    frontend_dir = Path.join(root, "project/frontend")

    machine_name =
      case Map.has_key?(config, env) do
        true -> Map.get(config, env)
        false -> exit("Environment '#{env}' is not configured.")
      end

    Sip.Utils.set_env(machine_name)

    IO.puts "📦 Building frontend..."

    commands(master_compose).frontend_build
    |> Sip.Utils.run_command(verbose, frontend_dir)

  end


  defp is_valid(config) do
    case config do
      {:ok, data} -> data
      {:error, msg} -> exit(msg)
    end
  end


  defp commands(compose_file) do
    %{
      frontend_build: "npm run build",
      docker_build: "docker-compose -f #{compose_file} build",
      docker_run: "docker-compose -f #{compose_file} up -d"
    }
  end

end
