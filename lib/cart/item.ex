defmodule Cart.Item do
    use Ecto.Schema
    import Ecto.Changeset

    alias Cart.InvoiceItem

    @primary_key {:id, :binary_id, autogenerate: true}
    schema "items" do
        field :name, :string
        field :price, :decimal, precision: 12, scale: 2
        has_many :invoice_items, InvoiceItem

        timestamps()
    end

    @fields ~w(name price)

    def changeset(data, params \\ %{}) do
        data
        |> cast(params, @fields)
        |> validate_required([:name, :price])
        |> validate_number(:price, greater_than_or_equal_to: Decimal.new(0))
    end
end