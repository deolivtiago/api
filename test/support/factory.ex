defmodule Api.Factory do
  @moduledoc """
  Defines factories for generating data
  """
  use ExMachina.Ecto, repo: Api.Repo

  use Api.Factories.UserFactory
end
