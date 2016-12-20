defmodule Sip.Deploy do

  def deploy([verbose: verbose, project: project, deploy: env]) do
    deploy_to_environment(project, env, verbose)
  end


  defp deploy_to_environment(project, env, verbose) do
    root = is_valid(Sip.Config.project_dir(project))
    {_, config} = Sip.Config.get_config({:ok, root})
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
