require 'yaml'

desc 'Build project'
arg_name 'Build your project.'
command :build do |c|
  c.action do |global_options,options,args|
    pandook_yaml = YAML::load(File.read('pandook.yaml'))

    pandoc_input = './tmp/pandoc_input'
    pandoc_output = 'index'

    FileUtils.mkdir_p('tmp')

    File.open(pandoc_input, 'w+') do |f|
      pandook_yaml['content'].each do |content_file|
        f.write(File.read("content/#{content_file}"))
        f.write("\n")
      end
    end

    from = pandook_yaml['pandoc']['from']
    to = pandook_yaml['pandoc']['to']
    to.each do |format|
      FileUtils.mkdir_p("output/#{format}")

      case format
      when 'html'
        `pandoc #{pandoc_input} --from #{from} --to html -o output/#{format}/#{pandoc_output}.#{format}`
      when 'pdf'
        `pandoc #{pandoc_input} --from #{from} --to latex -o output/#{format}/#{pandoc_output}.#{format}`
      end
    end
  end
end
