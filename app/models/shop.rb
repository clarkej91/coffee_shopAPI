class Shop

  if(ENV['DATABASE_URL'])
      uri = URI.parse(ENV['DATABASE_URL'])
      DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)


    else
       DB = PG.connect({:host => "localhost", :port => 5432, :dbname => 'coffee_shops_development'})

    end

  def self.all
    results = DB.exec("SELECT * FROM shops;")
    return results.map do |result|
        {
            "id" => result["id"].to_i,
            "name" => result["name"],
            "location" => result["location"],
            "drink" => result["drink"],
            "liked" =>
            if result["liked"] === 'f'
              result["liked"] = false
            else
              result["liked"] = true
            end
        }
      end
  end

  def self.find(id)
    results = DB.exec("SELECT * FROM shops WHERE id=#{id};")
    return {
      "id" => results.first["id"].to_i,
      "name" => results.first["name"],
      "location" => results.first["location"],
      "drink" => results.first["drink"],
      "liked" =>
        if result["liked"] === 'f'
          result["liked"] = false
        else
          result["liked"] = true
        end
    }
  end

  def self.create(opts)
    results = DB.exec(
      <<-SQL
        INSERT INTO shops (name, location, drink, liked)
        VALUES ( '#{opts["name"]}', '#{opts["location"]}', '#{opts["drink"]}' '#{opts["liked"]}')
        RETURNING id, name, location, drink, liked;
      SQL
    )
    return {
      "id" => results.first["id"].to_i,
      "name" => results.first["name"],
      "location" => results.first["location"],
      "drink" => results.first["drink"],
      "liked" => liked
    }
  end

  def self.delete(id)
    results = DB.exec("DELETE FROM shops WHERE id=#{id};")
    return { "delete" => true}
  end

  def self.update(id, opts)
    results = DB.exec(
      <<-SQL
        UPDATE shops
        SET name='#{opts["name"]}', location='#{opts["location"]}', drink='#{opts["drink"]}'
        WHERE id=#{id}
        RETURNING id, name, location, drink;
      SQL
    )
    return {
      "id" => results.first["id"].to_i,
      "name" => results.first["name"],
      "location" => results.first["location"],
      "drink" => results.first["drink"]
    }

  end

end
