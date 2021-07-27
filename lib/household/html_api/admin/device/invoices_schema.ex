defmodule Household.HtmlApi.Device.InvoicesSchema do
  use Ecto.Schema

  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "invoices" do
    field :name, :string, size: 150, null: false
    field :last_name, :string, size: 150, null: false
    field :price, :string, size: 150, null: false
    field :mobile, :string, size: 11, null: false
    field :description, :string, null: false
    field :code, :string, size: 200, null: false

    field :delivary_time, :utc_datetime, null: false

    belongs_to :invoice_statuses, Household.HtmlApi.Device.InvoiceStatusSchema,
      foreign_key: :invoice_status_id,
      type: :binary_id

    belongs_to :brands, Household.HtmlApi.Device.BrandSchema,
      foreign_key: :brand_id,
      type: :binary_id

    belongs_to :devices, Household.HtmlApi.Device.DeviceSchema,
      foreign_key: :device_id,
      type: :binary_id

    timestamps()
  end

  def changeset(brand, params \\ %{}) do
    brand
    |> cast(params, [
      :name,
      :last_name,
      :price,
      :mobile,
      :description,
      :code,
      :delivary_time,
      :invoice_status_id,
      :brand_id,
      :device_id
    ])
    |> validate_required(
      [
        :name,
        :last_name,
        :price,
        :mobile,
        :description,
        :code,
        :invoice_status_id,
        :brand_id,
        :device_id
      ],
      message: "تمامی فیلدهای موردنظر باید وارد شود."
    )
    |> validate_length(:name, max: 150, message: "حداکثر مجاز ۱۵۰ کاراکتر می باشد.")
    |> foreign_key_constraint(:invoice_status_id)
    |> foreign_key_constraint(:brand_id)
    |> foreign_key_constraint(:device_id)
    |> unique_constraint(:name,
      name: :unique_index_on_invoice_statuses_name,
      message: "تیتر وضعیت تحویل تکراری می باشد."
    )
  end
end
