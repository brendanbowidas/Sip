defmodule Sip.Ops do
  def deploy([ops: _, deploy: env]) do
    env
    |> deploy_to_environment
  end

  defp deploy_to_environment(env) do
    
  end
end
