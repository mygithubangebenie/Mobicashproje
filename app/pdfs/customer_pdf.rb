class CustomerPdf < Prawn::Document
  def initialize(customers)
    super()
    @customers= Customer.all
    customer_id
  end
  def customer_id
    table customer_id_all do
      row(0).font_style= :bold
      columns(1..3).align=:right
      self.row_colors=["DDDDDD","FFFFFF"]
      self.header=true
    end
  end
  def customer_id_all
    [["Names", "Date of Birth", "National Id", "Adress"]] +
    @customers.map do |customer|
      [customer.name, customer.dob, customer.nationality, customer.phone]
    end
  end
end