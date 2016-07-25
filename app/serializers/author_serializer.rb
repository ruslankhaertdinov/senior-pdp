class AuthorSerializer < ApplicationSerializer
  attributes :lat, :lng, :info

  def lat
    object.latitude
  end

  def lng
    object.longitude
  end

  def info
    object.full_name
  end
end
