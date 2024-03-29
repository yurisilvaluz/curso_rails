require 'tty-spinner'

TTY::Formats::FORMATS.each_key do |token|
    options = {format: token, hide_cursor: true}
    spinner = TTY::Spinner.new("#{token}: :spinner", options)
    20.times do
    spinner.spin
    sleep(0.1)
    end
    spinner.stop
end