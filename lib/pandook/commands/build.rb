desc 'Build project'
arg_name 'Build your project.'
command :build do |c|
  c.action do |global_options,options,args|
    puts "build command ran"
  end
end
