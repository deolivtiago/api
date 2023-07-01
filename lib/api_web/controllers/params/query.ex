defmodule ApiWeb.Params.Query do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false

  @attrs ~w(sort_by order)a

  embedded_schema do
    field :sort_by, Ecto.Enum,
      values: [
        id: "ID",
        name: "NAME",
        email: "EMAIL",
        inserted_at: "INSERTED_AT",
        updated_at: "UPDATED_AT"
      ]

    field :order, Ecto.Enum, values: [asc: "ASC", desc: "DESC"], default: :asc
  end

  def validate(params) do
    %__MODULE__{}
    |> cast(params, @attrs)
    |> apply_action(:validate)
  end
end
