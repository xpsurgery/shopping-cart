require 'hashie/mash'

module Config

  DEFAULTS = Hashie::Mash.new({
    initial_balance: 10000,
    payroll: {
      interval_secs: 60,
      wage_bill: 100
    },
    sales: {
      expiry_secs: 3,
      commission: 500,
      fine_for_late_attempt: 0,
      fine_for_tax_error: 300,
      fine_for_missing_discount: 50,
      fine_for_incorrect: 500
    },
    regions: {
      BE: {
        sales_tax: 8.25,
        discount_bands: [
          { total_less_than: 1000, discount: 0.00 },
          { total_less_than: 5000, discount: 0.03 },
          { total_less_than: 7000, discount: 0.05 },
          { discount: 0.085 }
        ]
      },
      FR: {
        sales_tax: 6.25,
        discount_bands: [
          { total_less_than: 1000, discount: 0.00 },
          { total_less_than: 5000, discount: 0.03 },
          { total_less_than: 7000, discount: 0.05 },
          { discount: 0.085 }
        ]
      },
      IT: {
        sales_tax: 6.85,
        discount_bands: [
          { total_less_than: 1000, discount: 0.00 },
          { total_less_than: 5000, discount: 0.03 },
          { total_less_than: 7000, discount: 0.05 },
          { discount: 0.085 }
        ]
      },
      ES: {
        sales_tax: 8.00,
        discount_bands: [
          { total_less_than: 1000, discount: 0.00 },
          { total_less_than: 5000, discount: 0.03 },
          { total_less_than: 7000, discount: 0.05 },
          { discount: 0.085 }
        ]
      },
      NL: {
        sales_tax: 4.00,
        discount_bands: [
          { total_less_than: 1000, discount: 0.00 },
          { total_less_than: 5000, discount: 0.03 },
          { total_less_than: 7000, discount: 0.05 },
          { discount: 0.085 }
        ]
      }
    }
  })

end

