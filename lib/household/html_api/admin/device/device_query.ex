defmodule Household.HtmlApi.Device.DeviceQuery do

  alias Household.HtmlApi.Device.DeviceSchema
  alias Household.Repo
  def add_device(attrs) do
    %DeviceSchema{}
    |> DeviceSchema.changeset(attrs)
    |> Repo.insert()
  end

end

# <p class="alert alert-info" role="alert"><%= get_flash(@conn, :info) %></p>
#       <p class="alert alert-danger" role="alert"><%= get_flash(@conn, :error) %></p>
