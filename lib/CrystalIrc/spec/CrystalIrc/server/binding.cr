def server_process_client(s, cli)
  cli.send_raw ":0 NOTICE Auth :***You are connected***"
  begin
    loop do
      cli.gets do |str|
        STDERR.puts "server->cli.gets: #{str}" if ::VERBOSE == true
        return if str.nil?
        s.handle str, cli
      end
    end
  rescue e
    return if e.message == "Error writing file: Broken pipe"
    STDERR.puts "Error during client proccess: #{e}"
  end
end

def client_fetch(cli, str)
  STDERR.puts "fetch: #{str}" if ::VERBOSE == true
end

describe CrystalIrc::Server::Binding do
  it "Server binding" do
    s = CrystalIrc::Server.new(host: "127.0.0.1", port: 6667_u16, ssl: false)
    s.on("JOIN") do |msg|
      chan_name = msg.raw_arguments
      msg.command.should eq("JOIN")
      msg.raw_arguments.should eq("#toto") # chan_name
      # note: this message is already sent
      # msg.sender.send_raw ":0 NOTICE JOIN :#{chan_name}"
    end

    spawn { spawn server_process_client(s, s.accept) }
    cli = CrystalIrc::Client.new(nick: "nick", ip: "127.0.0.1", port: 6667_u16, ssl: false)
    cli.connect
    client_fetch cli, cli.gets
    # cli.send_login
    sleep 0.5
    cli.join([CrystalIrc::Chan.new "#toto"])
    sleep 0.5
    msg = cli.gets.to_s.chomp
    client_fetch cli, msg
    msg.should eq(":0 NOTICE user :JOINED #toto")
    cli.ping
    cli.gets.to_s.chomp.should eq("PONG :0")
    cli.ping "azerty 42"
    cli.gets.to_s.chomp.should eq("PONG :azerty 42")
    s.close
  end
end
