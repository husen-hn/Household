defmodule Household.HtmlApi.Device.DeviceQuery do
  import Ecto.Query
  alias Household.HtmlApi.Device.DeviceSchema
  alias Household.Repo

  def get_device_with_id(id) do
    Repo.get!(DeviceSchema, id)
  end

  def add_device(attrs) do
    %DeviceSchema{}
    |> DeviceSchema.changeset(attrs)
    |> Repo.insert()
  end


  def delete_device(id) do
    get_device_with_id(id)
    |> Repo.delete
  end

  def devices do
    query = from u in DeviceSchema,
    order_by: [desc: u.inserted_at],
    select: %{
      id: u.id,
      name: u.name,
      inserted_at: u.inserted_at,
      updated_at: u.updated_at
    }
    Repo.all(query)
  end
end
