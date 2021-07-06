defmodule Household.Repo.Migrations.Devices do
  use Ecto.Migration
  @disable_ddl_transaction true

  def change do
    create table(:devices, primary_key: false) do
      add :id, :uuid, primary_key: false
      add :name, :string, null: false
      timestamps()
    end
    create table(:brands, primary_key: false) do
      add :id, :uuid, primary_key: false
      add :name, :string, null: false
      timestamps()
    end
  end
end
