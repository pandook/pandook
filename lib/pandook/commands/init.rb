desc 'Init a project'
arg_name 'path', [:multiple, :optional]
command :init do |c|
  c.desc "title of your project"
  c.flag [:T, :title]

  c.desc "Type of your project, options: book|article"
  c.flag [:t, :type]

  c.action do |global_options,options,args|
    help_now!("There should be a path.") if args.empty?
    help_now!("There should be only one path.") if args.length > 1

    DEFAULT_PANDOOK_YAML = <<EOF
---

title: #{options[:title] || "Title" }
type: #{options[:type] || "book" }       # options: book|article
toc: true                     # options: true|false
lof: true                     # options: true|false
lot: true                     # options: true|false
content: []                   # list of files
pandoc:
  - from:                     # `-f FORMAT`, `-r FORMAT`, `--from=FORMAT`, `--read=FORMAT`
  - to:                       # `-t FORMAT`, `-w FORMAT`, `--to=FORMAT`, `--write=FORMAT`
  - output:                   # `-o FILENAME`, `--output=FILENAME`
  - filter:                   # `-F PROGRAM`, `--filter=PROGRAM`
  - smart: true               # `--smart`, options: true|false
  - filter:                   # `--filter=PROGRAM`
  - standalone:               # `--standalone`
  - toc: true                 # `--toc-depth=NUMBER`, options: true|false
  - include-in-header:        # `-H FILENAME`, `--include-in-header=FILENAME`
  - include-before-body:      # `-B FILENAME`, `--include-before-body=FILENAME`
  - include-after-body:       # `-A FILENAME`, `--include-after-body=FILENAME`
  - html5: true               # `--html5`, options: true|false
  - latex-engine: xelatex     # `--latex-engine=PROGRAM`
  - latex-engine-opts:        # `--latex-engine-opt=STRING`
EOF

    path = args[0]

    if File.exists?(path) && (!File.directory?(path) || !(Dir.entries(path) - %w(. ..)).empty?)
      raise "Path #{path} exists, please specify another path."
    end

    FileUtils.mkdir_p(path)
    FileUtils.cd(File.join(path)) do
      FileUtils.mkdir_p('content')
      FileUtils.mkdir_p('output')
      File.write('pandook.yaml', DEFAULT_PANDOOK_YAML)
    end

    puts "Created a blank pandook project at '#{path}'. Enjoy!"
  end
end
