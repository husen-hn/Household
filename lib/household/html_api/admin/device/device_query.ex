defmodule Household.HtmlApi.Device.DeviceQuery do
  import Ecto.Query
  alias Household.HtmlApi.Device.DeviceSchema
  alias Household.Repo
  def add_device(attrs) do
    %DeviceSchema{}
    |> DeviceSchema.changeset(attrs)
    |> Repo.insert()
  end

  def devices do
    query = from u in DeviceSchema,
    order_by: [desc: u.inserted_at],
    select: %{
      name: u.name,
      inserted_at: u.inserted_at,
      updated_at: u.updated_at
    }
    Repo.all(query)
  end
end
