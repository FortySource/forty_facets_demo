class MovieSearch < FortyFacets::FacetSearch
  model 'Movie'

  text  :title, name: 'Title'
  range :price, name: 'Price'
  facet :genre, name: 'Genre'
  facet :year,  order: Proc.new { |year| -year }

  facet :studio,  name: 'Studio',  order: :name
  facet :actors,  name: 'Actors',  order: :name
  facet :writers, name: 'Writers', order: :name

  orders 'Title' => :title,
         'price, cheap first' => "price asc",
         'price, expensive first' => {price: :desc, title: :desc}

end
