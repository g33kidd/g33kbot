require "duktape"

# TODO: This is completely fucked. Figure out how to fix it..
# TODO: This is completely fucked. Figure out how to fix it..
# TODO: This is completely fucked. Figure out how to fix it..
# TODO: This is completely fucked. Figure out how to fix it..

class JavascriptEvalCommand < Command
  include Utils

  description "Creates a javascript sandbox and runs some code. This command is completely fucked."

  def run(runner, payload, client)
    # Creats a sandbox with 100ms timeout.
    sandbox = Duktape::Sandbox.new 100
    code    = payload.content.strip("```js").strip("```").strip

    begin
      sandbox.eval! code
      # Interpret the last stack value and returns it...
      number  = sandbox.get_number(-1)
      string  = sandbox.get_string(-1)

      client.create_message payload.channel_id, "You ran some code in a Javascript \
      Sanbox, here's how it went. \n ```number value: \n#{number}\n\nstring value:\n#{string}```"
    rescue err : Duktape::Error
      client.create_message payload.channel_id, "Whoops... there was an error \
      trying to run your code \n `#{err}`"
    end
  end

  def can_run?(content)
    if content.starts_with?("```js") && content.ends_with?("```")
      true
    else
      false
    end
  end
end
