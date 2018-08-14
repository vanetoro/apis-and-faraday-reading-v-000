class SearchesController < ApplicationController
  def search
  end

  def foursquare
  @resp =  Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'OLVK1USG3GXQ0P0Z5THJLT1TB52RDWTC20FPEINA202UHUF4'
      req.params['client_secret'] = 'LMID0FKKPP21W1YDTLGSXZ0DEKXKLFIQKFZBRB20E00ZTPLU'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      binding.pry
      @error = body["meta"]["errorDetail"]
    end
    render 'search'
  end

end
