defmodule Api.Repo.Migrations.CreateUserTokens do
  use Ecto.Migration

  def change do
    create table(:user_tokens, primary_key: false) do
      add :jti, :binary_id, primary_key: true
      add :typ, :string, null: false
      add :aud, :string, null: false
      add :iss, :string, null: false
      add :sub, references(:users, on_delete: :delete_all, on_update: :update_all), null: false
      add :exp, :bigint, null: false
      add :token, :text, null: false
      add :claims, :map, null: false

      timestamps()
    end

    create index(:user_tokens, [:token])
  end
end
