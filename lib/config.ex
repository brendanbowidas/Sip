defmodule Sip.Config do
  def get_config(root_dir) do
    #TODO read config file from result of find_root
  end

  @doc """
    Find '.sip' config file in the root directory from any child directory in the project
  """
  def find_root do
    System.cwd
    |> traverse_path
  end

  @doc """
    traverse project directories recursively until the config file is found
  """
  defp traverse_path(dir) do
    paths = Path.split(dir)
    file? = Path.join(paths ++ [".sip"])
    case File.exists?(file?) do
      true -> file?
      false ->
        if length(paths) > 1 do
          paths
          |> List.delete_at(length(paths) - 1)
          |> Path.join
          |> traverse_path
        else
          IO.puts "Couldn't find .sip file in this project!"
        end

    end
  end
end
