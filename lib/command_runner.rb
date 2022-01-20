# frozen_string_literal: true

require_relative './robot'
class CommandRunner
  COMMANDS_REGEX = /(MOVE)|(LEFT)|(RIGHT)|(REPORT)|(PLACE) (\d),(\d),(NORTH|SOUTH|EAST|WEST)/.freeze
  def self.run(path, robot)
    #TODO path should be validated 
    File.foreach(path).with_index do |line, _line_num|
      match_data = line.match(COMMANDS_REGEX).captures.compact
      cmd = match_data[0].downcase
      params = match_data[1..]
      if params.any?
        params[-3] = params[-3].to_i
        params[-2] = params[-2].to_i
        params[-1] = params[-1].downcase.to_sym
      end
      robot.send(cmd, *params)
    end
  end
end
