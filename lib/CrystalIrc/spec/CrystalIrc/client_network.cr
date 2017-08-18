# ::VERBOSE = true

def test_cli1(cli : CrystalIrc::Client, chan = "#nyupatate")
  cli.connect do |s|
    s.should be_a(CrystalIrc::IrcSender)
    spawn do
      loop do
        break if cli.closed?
        cli.gets { |msg| puts "> #{msg}" } rescue nil
      end
    end
    sleep 1
    chan = CrystalIrc::Chan.new(chan.as(String))
    cli.join([chan])
    cli.privmsg(target: chan, msg: "I'm a dwarf and I'm digging a hole. Diggy diggy hole.")
    sleep 1
  end
end

describe CrystalIrc::Client do
  it "Test close with server" do
    CrystalIrc::Server.open(ssl: false, port: 6666_u16) do |server|
      cli = CrystalIrc::Client.new ip: "localhost", port: 6666_u16, ssl: false, nick: "CrystalBotSpecS_#{rand 100..999}"
      cli.connect do |_|
        cli.closed?.should eq(false)
        cli.close
        cli.closed?.should eq(true)
        expect_raises { cli.gets { } }
      end
    end
    sleep 0.5
  end
end
