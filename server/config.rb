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
      penalty_for_late_attempt: 0,
      commission: 500,                                          # TODO: per region
      penalty_for_missing_tax: 300,
      penalty_for_missing_discount: 50,
      penalty_for_incorrect: 500
    },
    regions: {
      BE: {
        sales_tax_percent: 8.25,
        discount_bands: [
          { total_less_than:  1000, discount_percent: 0 },
          { total_less_than:  5000, discount_percent: 3 },
          { total_less_than:  9000, discount_percent: 5 },
          { total_less_than: 13000, discount_percent: 7 },
          { discount_percent: 8.5 }
        ]
      },
      FR: {
        sales_tax_percent: 6.25,
        discount_bands: [
          { total_less_than:  1000, discount_percent: 0 },
          { total_less_than:  5000, discount_percent: 3 },
          { total_less_than:  9000, discount_percent: 5 },
          { total_less_than: 13000, discount_percent: 7 },
          { discount_percent: 8.5 }
        ]
      },
      IT: {
        sales_tax_percent: 6.85,
        discount_bands: [
          { total_less_than:  1000, discount_percent: 0 },
          { total_less_than:  5000, discount_percent: 3 },
          { total_less_than:  9000, discount_percent: 5 },
          { total_less_than: 13000, discount_percent: 7 },
          { discount_percent: 8.5 }
        ]
      },
      ES: {
        sales_tax_percent: 8.00,
        discount_bands: [
          { total_less_than:  1000, discount_percent: 0 },
          { total_less_than:  5000, discount_percent: 3 },
          { total_less_than:  9000, discount_percent: 5 },
          { total_less_than: 13000, discount_percent: 7 },
          { discount_percent: 8.5 }
        ]
      },
      NL: {
        sales_tax_percent: 4.00,
        discount_bands: [
          { total_less_than:  1000, discount_percent: 0 },
          { total_less_than:  5000, discount_percent: 3 },
          { total_less_than:  9000, discount_percent: 5 },
          { total_less_than: 13000, discount_percent: 7 },
          { discount_percent: 8.5 }
        ]
      }
    }
  })

end

