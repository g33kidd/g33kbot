module CrystalIrc::Command::Chan
  # Formats the chans to join: #chan1,#chan2 (works with users by the same way)
  protected def format_list(chans : Enumerable(CrystalIrc::Target)) : String
    chans.map { |c| c.name }.to_set.join(",")
  end

  # Requests to join the chan(s) chans, with password(s) passwords.
  # The passwords may be ignored if not needed.
  def join(chans : Enumerable(CrystalIrc::Chan), passwords : Enumerable(String) = [""])
    to_join = format_list(chans)
    passes = passwords.uniq.join(",")
    send_raw "JOIN #{to_join} #{passes}"
  end

  # Requests to leave the channel(s) chans, with an optional part message msg.
  def part(chans : Enumerable(CrystalIrc::Chan), msg : String? = nil)
    to_leave = format_list(chans)
    msg = ":#{msg}" if msg
    send_raw "PART #{to_leave} #{msg}"
  end

  # Requests to change the mode of the given channel.
  # If the mode is to be applied to an user, precise it.
  def mode(chan : CrystalIrc::Chan, flags : String, user : CrystalIrc::User? = nil)
    target = user ? user.name : ""
    send_raw "MODE #{chan.name} #{flags} #{target}"
  end

  # Requests to change the topic of the given channel.
  # If no topic is given, requests the topic of the given channel.
  def topic(chan : CrystalIrc::Chan, topic : String)
    send_raw "TOPIC #{chan.name} :#{topic}"
  end

  # Requests the names of the users in the given channel(s).
  # If no channel is given, requests the names of the users in every
  # known channel.
  def names(chans : Enumerable(CrystalIrc::Chan))
    target = format_list(chans)
    send_raw "NAMES #{target}"
  end

  # Lists the channels and their topics.
  # If the chans parameter is given, lists the status of the given chans.
  def list(chans : Enumerable(CrystalIrc::Chan))
    target = format_list(chans)
    send_raw "LIST #{target}"
  end

  # Invites the user user to the channel chan.
  def invite(chan : CrystalIrc::Chan, user : CrystalIrc::User)
    send_raw "INVITE #{user.name} #{chan.name}"
  end

  # Kicks the user(s) users from the channel(s) chans.
  # The reason of the kick will be displayed if given as a parameter.
  def kick(chans : Enumerable(CrystalIrc::Chan), users : Enumerable(CrystalIrc::User), reason : String? = nil)
    chan = format_list(chans)
    targets = format_list(users)
    reason = ":#{reason}" if reason
    send_raw "KICK #{chan} #{targets} #{reason}"
  end
end
