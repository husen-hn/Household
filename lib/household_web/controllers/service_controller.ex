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
      {:ok, _device_info} ->
        conn
        |> put_flash(:success, "ذخیره شما با موفقیت انجام گردید.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :devices)}")
      {:error, changeset} ->
        conn
        |> put_flash(:danger, "مشکلی در فرم شما وجود دارد.")
        render(conn, "new_device.html", changeset: changeset)
    end
  end

  def delete_device(conn, %{"id" => id}) do
    with {:ok, device_id} <- Ecto.UUID.cast(id),
      {:ok, _device_info} <- DeviceQuery.delete_device(device_id) do
        conn
        |> put_flash(:success, "دستگاه مورد نظر شما حذف گردید.")
        |> redirect(to: "/devices")
    else
      _ ->
        conn
        |> put_flash(:danger, "مشکلی در حذف اتفاق افتاده است.")
        |> redirect(to: "/devices")
    end
  end
end
