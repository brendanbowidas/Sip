defmodule Sip.Config do

  def get_config(root_dir) do
    case root_dir do
      {:ok, file_path} ->
        {_ok, file} = File.read("#{file_path}/.sip")
        Poison.decode(file)

      {:error, msg} ->
         {:error, msg}
    end
  end


  @doc """
    Find '.sip' config file in the root directory from any child directory in the project
  """
  def find_root do
    System.cwd
    |> traverse_project
  end


  @doc """
    traverse project directories recursively until the config file is found
  """
  defp traverse_project(dir) do
    paths = Path.split(dir)
    file? = Path.join(paths ++ [".sip"])

    case File.exists?(file?) do
      true -> {:ok, Path.join(paths)}
      false ->
        if length(paths) > 1 do
          paths
          |> List.delete_at(length(paths) - 1)
          |> Path.join
          |> traverse_project
        else
          {:error, "Couldn't find .sip file in this project!"}
        end
    end

  end

end
