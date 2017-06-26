class Stock < ActiveRecord::Base
    has_many :user_stocks, dependent: :destroy
    has_many :users, through: :user_stocks
    
    def self.find_by_ticker(ticker_symbol)
       where(ticker: ticker_symbol).first 
    end
    
    def self.new_from_lookup(ticker_symbol)
       looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
       return nil unless looked_up_stock.name
       
       new_stock = Stock.new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
       new_stock.last_price = new_stock.price
       return new_stock
    end
    
    def price
        close_price = StockQuote::Stock.quote(ticker).close
        return close_price if close_price
        current_price = StockQuote::Stock.quote(ticker).last_trade_price_only
        return current_price if current_price
        return "NA"
    end
end
