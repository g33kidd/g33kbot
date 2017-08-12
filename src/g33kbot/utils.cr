module Utils

  def contains_any?(content, strings : Array(String)) : Bool
    arr = [] of String
    strings.each do |s|
      if content.includes? s
        arr.push(s)
      end
    end

    if arr.size == 0
      false
    else
      true
    end
  end

end
