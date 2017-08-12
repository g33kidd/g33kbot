require "http/client"
require "xml"
require "uri"

# This uses http://thecatapi.com/docs.html
class CatsCommand < Command
  global_prefix true
  signature "cat"
  description "Gets a random cat image. Using thecatapi.com"

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

        # TODO: Make it upload an image...
        # puts URI.parse(url).pretty_inspect
        # HTTP::Client.get(url) do |resp|
        #   File.write("./test", resp.body_io)
        #   client.upload_file payload.channel_id, "", resp.body_io
        # end
        client.create_message payload.channel_id, "Here's a cat: #{url}"
      else
        client.create_message payload.channel_id, "Whoops... couldn't find anything."
      end
    end
  end
end
