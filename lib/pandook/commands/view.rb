desc 'View output'
arg_name 'Describe arguments to view here'
command :view do |c|
  c.action do |global_options,options,args|
    puts "view command ran"
  end
end
