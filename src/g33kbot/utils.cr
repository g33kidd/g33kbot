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

  # Removes the Command string from the given content
  def strip_command(runner, command, content)
    command_string = runner.get_command_string(command)
    content.not_nil!.strip("#{command_string}")
  end

end
