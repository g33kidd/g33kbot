class TestCommand < Command
  # prefix "!"
  global_prefix true
  signature "test"
  description "This is test? Hello?"

  def run(runner, payload, client)
    embed = Discord::Embed.new(
      title: "Title of Embed",
      description: "Description of embed. This can be a long text. Neque porro quisquam est, qui dolorem ipsum, quia dolor sit, amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam quaerat voluptatem.",
      timestamp: Time.now,
      url: "https://example.com",
      image: Discord::EmbedImage.new(
        url: "https://example.com/image.png",
      ),
      fields: [
        Discord::EmbedField.new(
          name: "Name of Field",
          value: "Value of Field",
        ),
      ],
    )

    client.create_message(payload.channel_id, "The content of the message. This will display separately above the embed. This string can be empty.", embed)
  end
end
