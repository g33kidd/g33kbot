require "duktape/runtime"

# TODO: This is completely fucked. Figure out how to fix it..
# TODO: This is completely fucked. Figure out how to fix it..
# TODO: This is completely fucked. Figure out how to fix it..
# TODO: This is completely fucked. Figure out how to fix it..

class JavascriptEvalCommand < Command
  include Utils

  description "Runs some JS"
  # starts_with "```js"
  # ends_with "```"

  rules do |payload|
    return payload.content.starts_with?("```js") &&
      payload.content.ends_with?("```")
  end

  handle do |payload, client|
    # Creats a sandbox with 100ms timeout.
    sandbox = Duktape::Sandbox.new 100
    sandbox.push_global_object
    sandbox.del_prop_string(-1, "print")
    sandbox.del_prop_string(-1, "alert")
    sandbox.pop

    runtime = Duktape::Runtime.new sandbox

    code = payload.content.strip("```js").strip("```").strip

    begin
      result = runtime.eval code
      client.create_message payload.channel_id, "You ran some code in a Javascript \
      Sanbox, here's how it went. \n ```#{result}```"
    rescue err : Duktape::Error
      client.create_message payload.channel_id, "Whoops... there was an error \
      trying to run your code \n `#{err}`"
    end
  end
end
