defmodule Api.Accounts.User.List do
  @moduledoc false
  alias Api.Accounts.User
  alias Api.Repo
  alias ApiWeb.Params.Query
  alias Ecto.Changeset

  @user_attrs ~w(id name email)a
  @date_attrs ~w(inserted_at updated_at)a

  @doc false
  # def call(params) when is_map(params) do
  #   Keyword.new()
  #   |> Keyword.put(:order, Map.get(params, "order", "asc") |> String.to_atom())
  #   |> Keyword.put(:sort_by, Map.get(params, "sort_by", "name") |> String.to_atom())
  #   |> call()
  # end

  def call(%{} = params) do
    params
    |> Query.validate()
    |> call()
  end

  def call({:ok, %Query{sort_by: attr, order: order}}) when attr in @user_attrs do
    User
    |> Repo.all()
    |> Enum.sort_by(&Map.get(&1, attr), order)
    |> then(&{:ok, &1})
  end

  @doc false
  def call({:ok, %Query{sort_by: attr, order: order}}) when attr in @date_attrs do
    User
    |> Repo.all()
    |> Enum.sort_by(&Map.get(&1, attr), {order, DateTime})
    |> then(&{:ok, &1})
  end

  @doc false
  def call({:error, %Changeset{} = changeset}), do: {:error, changeset}

  def call(_params), do: {:ok, Repo.all(User)}
end
