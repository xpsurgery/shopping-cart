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
        sales_tax_percent: 8.25,
        discount_bands: [
          { total_less_than:  1000, percent_discount: 0 },
          { total_less_than:  5000, percent_discount: 3 },
          { total_less_than:  9000, percent_discount: 5 },
          { total_less_than: 13000, percent_discount: 7 },
          { percent_discount: 8.5 }
        ]
      },
      FR: {
        sales_tax_percent: 6.25,
        discount_bands: [
          { total_less_than:  1000, percent_discount: 0 },
          { total_less_than:  5000, percent_discount: 3 },
          { total_less_than:  9000, percent_discount: 5 },
          { total_less_than: 13000, percent_discount: 7 },
          { percent_discount: 8.5 }
        ]
      },
      IT: {
        sales_tax_percent: 6.85,
        discount_bands: [
          { total_less_than:  1000, percent_discount: 0 },
          { total_less_than:  5000, percent_discount: 3 },
          { total_less_than:  9000, percent_discount: 5 },
          { total_less_than: 13000, percent_discount: 7 },
          { percent_discount: 8.5 }
        ]
      },
      ES: {
        sales_tax_percent: 8.00,
        discount_bands: [
          { total_less_than:  1000, percent_discount: 0 },
          { total_less_than:  5000, percent_discount: 3 },
          { total_less_than:  9000, percent_discount: 5 },
          { total_less_than: 13000, percent_discount: 7 },
          { percent_discount: 8.5 }
        ]
      },
      NL: {
        sales_tax_percent: 4.00,
        discount_bands: [
          { total_less_than:  1000, percent_discount: 0 },
          { total_less_than:  5000, percent_discount: 3 },
          { total_less_than:  9000, percent_discount: 5 },
          { total_less_than: 13000, percent_discount: 7 },
          { percent_discount: 8.5 }
        ]
      }
    }
  })

end

