require_relative './lib/robot'
require_relative './lib/command_runner'


if __FILE__ == $0
  if ARGV.length < 1
    puts "Error: Too few arguments"
    puts "" "ToyRobot 0.0.1
      Usage: ruby toy_robot.rb <TXT_PATH>
    " ""
    exit
  end
  robot = Robot.new()
  CommandRunner.run(ARGV[0], robot)
end