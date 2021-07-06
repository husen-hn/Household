defmodule Household.HtmlApi.Device.DeviceQuery do
  import Ecto.Query
  alias Household.HtmlApi.Device.DeviceSchema
  alias Household.Repo
  # CRUD
  # Device
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

  def update_device(device, attrs) do
    DeviceSchema.changeset(device, attrs)
    |> Repo.update
  end

  def edit_device(id, new_device) do
    get_device_with_id(id)
    |> update_device(new_device)
  end
end
