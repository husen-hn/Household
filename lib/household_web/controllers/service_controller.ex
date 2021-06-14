defmodule HouseholdWeb.ServiceController do
  use HouseholdWeb, :controller
  alias Household.HtmlApi.Device.DeviceSchema
  alias Household.HtmlApi.Device.DeviceQuery

  def devices(conn, _params) do
    render(conn, "devices.html", devices: DeviceQuery.devices())
  end

  def new_device(conn, _params) do
    changeset = DeviceSchema.changeset(%DeviceSchema{})
    render(conn, "new_device.html", changeset: changeset)
  end

  def add_device(conn, %{"device_schema" => device}) do
    case DeviceQuery.add_device(device) do
      {:ok, device_info} ->
        conn
        |> put_flash(:success, "ذخیره شما با موفقیت انجام گردید.")
        |> redirect(to: "/new-device")
      {:error, changeset} ->
        conn
        |> put_flash(:danger, "مشکلی در فرم شما وجود دارد.")
        render(conn, "new_device.html", changeset: changeset)
    end


  end
end
