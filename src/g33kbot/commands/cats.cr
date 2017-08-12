require "http/client"
require "hq"

class CatsCommand < Command
  global_prefix true
  signature "cat"
  description "Supposed to get a random image of a cat."

  # TODO: Find a JSON API to clean this code up a bit... or just clean it up somehow.

  def run(runner, payload, client)
    HTTP::Client.get("http://thecatapi.com/api/images/get?format=xml&results_per_page=1") do |response|

      if response.status_code == 200
        document  = XML.parse response.body_io
        content   = document.first_element_child.as(XML::Node)
        resp      = content.first_element_child.as(XML::Node)
        images    = resp.first_element_child.as(XML::Node)
        image     = images.first_element_child.as(XML::Node)
        url       = image.first_element_child.as(XML::Node).content

        client.create_message payload.channel_id, "#{url}"
      else
        client.create_message payload.channel_id, "Whoops... couldn't find anything."
      end
    end
  end
end
