#!/usr/bin/ruby
# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2:

require 'logger'

@log = Logger.new('./pomodoro.log', 7, 100*1024*1024)
@log.level = Logger::DEBUG

Signal.trap(:INT){
  @log.warn "!!!! Task Interruputed !!!!"
  exit(0)
}

def input
  print "Please input task description. : "
  @task = STDIN.gets.chomp
  @log.info "#{@task}"
end

def init_execute
  puts "Program Started."
  
  @set_time = ARGV[0].to_i
  minutes = @set_time
end

def output_time
  puts `clear`
  puts @task
  puts Time.now
end

def print_time(minutes, second)
  p sprintf("%02d:%02d minutes rest time.", minutes, second)
end

def init_print_time(minutes)
  p sprintf("%02d:%02d minutes.", @set_time, 00)
end

def error_msg
  puts "Limit time is empty."
  puts "Please relaunch this program."
  puts "Format => ruby pomodoro_timer.rb (minutes)[Enter]"
  exit(0)
end

def task_fin_msg
  puts "#{@set_time} minutes has past !!"
  @log.info "Task :[#{@task}] has been completed normally."
end

def pomodoro_fin_msg
  puts "5 minutes brake time has past !!"
  puts "One pomodoro has been completed."
  @log.info "One pomodoro has been completed."
  puts "Program End."
end

def timecount(minutes)
  if minutes != 0
    output_time
    init_print_time(minutes)
    minutes -= 1
  
    while minutes >= 0
      second = 60
      while second > 0
        sleep 1
      	output_time
        print_time(minutes, second)
        second -= 1
      end
      output_time
      print_time(minutes, second)
      minutes -= 1
    end
  else
    error_msg
  end
end

# Count active time.
input
minutes = init_execute
timecount(minutes)
task_fin_msg

# Count break time.
@task = "!!!! Break time !!!!"
@log.info "#{@task}"
timecount(5)

pomodoro_fin_msg
